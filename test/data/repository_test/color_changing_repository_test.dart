import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_app/data/repository/color_repository.dart';
import 'package:random_color_app/data/service/custom_color_changing_service.dart';
import 'package:random_color_app/data/service/simple_color_changing_service.dart';
import 'package:random_color_app/domain/model/app_color.dart';

void main() {
  late ColorRepository repository;
  late SimpleColorChangingService simpleService;
  late CustomColorChangingService customService;

  setUp(() {
    // Use predictable simple service with seed
    simpleService = SimpleColorChangingService(seed: 42);
    // First get expected values from the seeded service
    customService = CustomColorChangingService();

    repository = ColorRepository(
      simpleColorService: simpleService,
      customColorService: customService,
    );
  });

  group('ColorRepository', () {
    test('should use simple service for color generation', () async {
      // First get a reference color directly from the service
      final referenceColor =
          await SimpleColorChangingService(seed: 42).generateRandomColor();

      // Then get color from repository
      final repoColor = await repository.generateRandomColor();

      // Values should match exactly
      expect(repoColor.red, referenceColor.red);
      expect(repoColor.green, referenceColor.green);
      expect(repoColor.blue, referenceColor.blue);
    });

    test('should generate consistent colors with same seed', () async {
      // Create two repositories with same seeded service
      final service1 = SimpleColorChangingService(seed: 42);
      final service2 = SimpleColorChangingService(seed: 42);

      final repo1 = ColorRepository(
        simpleColorService: service1,
        customColorService: customService,
      );

      final repo2 = ColorRepository(
        simpleColorService: service2,
        customColorService: customService,
      );

      final color1 = await repo1.generateRandomColor();
      final color2 = await repo2.generateRandomColor();

      expect(color1.red, color2.red);
      expect(color1.green, color2.green);
      expect(color1.blue, color2.blue);
    });

    test('should use simple service for accessible colors', () async {
      const backgroundColor = AppColor(red: 0, green: 0, blue: 0);

      final repoColor = await repository.selectAccessibleColor(backgroundColor);

      // For pure black background, should get white text
      expect(repoColor.red, 255);
      expect(repoColor.green, 255);
      expect(repoColor.blue, 255);
    });

    test('should generate valid colors in sequence', () async {
      final colors = await Future.wait([
        repository.generateRandomColor(),
        repository.generateRandomColor(),
        repository.generateRandomColor(),
      ]);

      for (final color in colors) {
        expect(color.red, inInclusiveRange(0, 255));
        expect(color.green, inInclusiveRange(0, 255));
        expect(color.blue, inInclusiveRange(0, 255));
      }
    });
  });
}
