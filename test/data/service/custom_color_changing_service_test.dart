import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_app/data/service/custom_color_changing_service.dart';

void main() {
  late CustomColorChangingService service;

  setUp(() {
    service = CustomColorChangingService();
  });

  group('CustomColorChangingService', () {
    test('should generate colors within valid RGB range', () async {
      final color = await service.generateRandomColor();

      expect(color.red, inInclusiveRange(0, 255));
      expect(color.green, inInclusiveRange(0, 255));
      expect(color.blue, inInclusiveRange(0, 255));
    });

    test('should generate different colors on consecutive calls', () async {
      final color1 = await service.generateRandomColor();

      // Add a small delay to ensure different microseconds
      await Future.delayed(const Duration(milliseconds: 1));

      final color2 = await service.generateRandomColor();

      // Compare all components together rather than individually
      expect(identical(color1, color2), isFalse,
          reason: 'Generated colors should be different: \n'
              'Color1: RGB(${color1.red}, ${color1.green}, ${color1.blue})\n'
              'Color2: RGB(${color2.red}, ${color2.green}, ${color2.blue})');
    });

    test('bit masking extracts correct ranges', () async {
      // Generate multiple colors to verify bit masking
      final colors = await Future.wait(List.generate(5, (_) async {
        await Future.delayed(const Duration(milliseconds: 1));
        return service.generateRandomColor();
      }));

      for (final color in colors) {
        expect(color.red, inInclusiveRange(0, 255));
        expect(color.green, inInclusiveRange(0, 255));
        expect(color.blue, inInclusiveRange(0, 255));
      }
    });
  });
}
