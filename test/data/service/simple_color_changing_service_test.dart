import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_app/data/service/simple_color_changing_service.dart';

void main() {
  late SimpleColorChangingService service;

  setUp(() {
    service = SimpleColorChangingService(seed: 42);
  });

  group('SimpleColorChangingService', () {
    test('should generate colors within valid RGB range', () async {
      final color = await service.generateRandomColor();

      expect(color.red, inInclusiveRange(0, 255));
      expect(color.green, inInclusiveRange(0, 255));
      expect(color.blue, inInclusiveRange(0, 255));
    });

    test('should generate same sequence with same seed', () async {
      // Get first pair of colors
      final firstColor1 = await service.generateRandomColor();
      final firstColor2 = await service.generateRandomColor();

      // Create new service with same seed
      final newService = SimpleColorChangingService(seed: 42);
      final secondColor1 = await newService.generateRandomColor();
      final secondColor2 = await newService.generateRandomColor();

      // Compare sequences
      expect(firstColor1.red, equals(secondColor1.red));
      expect(firstColor1.green, equals(secondColor1.green));
      expect(firstColor1.blue, equals(secondColor1.blue));

      expect(firstColor2.red, equals(secondColor2.red));
      expect(firstColor2.green, equals(secondColor2.green));
      expect(firstColor2.blue, equals(secondColor2.blue));
    });

    test('different seeds should generate different colors', () async {
      final service1 = SimpleColorChangingService(seed: 42);
      final service2 = SimpleColorChangingService(seed: 43);

      final color1 = await service1.generateRandomColor();
      final color2 = await service2.generateRandomColor();

      // At least one component should be different
      expect(
          color1.red != color2.red ||
              color1.green != color2.green ||
              color1.blue != color2.blue,
          isTrue);
    });
  });
}
