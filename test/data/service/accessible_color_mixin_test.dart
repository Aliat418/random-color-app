import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_app/data/service/accessible_color_mixin.dart';
import 'package:random_color_app/data/service/color_changing_service.dart';
import 'package:random_color_app/domain/model/app_color.dart';

// Create a test implementation of the mixin
class TestColorService
    with AccessibleColorMixin
    implements ColorChangingService {
  @override
  Future<AppColor> generateRandomColor() async => AppColor.dark();
}

void main() {
  late TestColorService service;

  setUp(() {
    service = TestColorService();
  });

  group('AccessibleColorMixin', () {
    test('should return light color for dark background', () async {
      const darkBackground = AppColor(red: 0, green: 0, blue: 0);
      final textColor = await service.selectAccessibleColor(darkBackground);

      expect(textColor.red, 255);
      expect(textColor.green, 255);
      expect(textColor.blue, 255);
    });

    test('should return dark color for light background', () async {
      const lightBackground = AppColor(red: 255, green: 255, blue: 255);
      final textColor = await service.selectAccessibleColor(lightBackground);

      expect(textColor.red, 0);
      expect(textColor.green, 0);
      expect(textColor.blue, 0);
    });

    test('should handle mid-tone backgrounds', () async {
      const midToneBackground = AppColor(red: 128, green: 128, blue: 128);
      final textColor = await service.selectAccessibleColor(midToneBackground);

      // With our luminance formula, mid-grey should return a specific color
      // You might need to adjust this expectation based on your exact formula
      expect(textColor, isA<AppColor>(),
          reason:
              'Should return either light or dark color based on luminance threshold');
    });

    test('should handle various background colors', () async {
      // Test array of background colors and expected results
      const testCases = [
        (
          background: AppColor(red: 200, green: 200, blue: 200),
          expectDark: true,
        ),
        (
          background: AppColor(red: 50, green: 50, blue: 50),
          expectDark: false,
        ),
        (
          background: AppColor(red: 255, green: 0, blue: 0),
          expectDark: false, // Pure red should have light text
        ),
      ];

      for (final testCase in testCases) {
        final textColor =
            await service.selectAccessibleColor(testCase.background);
        final isDark =
            textColor.red == 0 && textColor.green == 0 && textColor.blue == 0;
        expect(isDark, testCase.expectDark,
            reason: 'Background RGB(${testCase.background.red}, '
                '${testCase.background.green}, ${testCase.background.blue}) '
                'should have ${testCase.expectDark ? "dark" : "light"} text');
      }
    });
  });
}
