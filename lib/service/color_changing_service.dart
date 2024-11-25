import 'dart:io';
import 'dart:math';

import 'package:injectable/injectable.dart';

import '../model/app_color.dart';
import '../utils/app_color_utils.dart';

abstract class ColorChangingService {
  Future<AppColor> generateRandomColor();

  Future<AppColor> selectAccessibleColor(AppColor backgroundColor) async {
    return ColorUtils.getAccessibleColor(backgroundColor);
  }
}

@named
@Singleton(as: ColorChangingService)
class SimpleColorChangingService extends ColorChangingService {
  // Use .secure() to be truly random
  final Random _random = Random();

  @override
  Future<AppColor> generateRandomColor() async => AppColor(
        red: _random.nextInt(256),
        green: _random.nextInt(256),
        blue: _random.nextInt(256),
      );
}

@named
@Singleton(as: ColorChangingService)
class CustomColorChangingService extends ColorChangingService {
  @override
  Future<AppColor> generateRandomColor() async {
    // Create unique seed by combining 3 values using XOR
    final seed = DateTime.now().microsecondsSinceEpoch ^
        Platform.operatingSystemVersion.hashCode ^
        Platform.localHostname.hashCode;

    // Extract RGB channels using bit masking
    final red = (seed & 0xFF000000) >> 24;
    final green = (seed & 0x00FF0000) >> 16;
    final blue = (seed & 0x0000FF00) >> 8;

    // Ensure values are within 0-255 range
    return AppColor(
      red: red.abs() % 256,
      green: green.abs() % 256,
      blue: blue.abs() % 256,
    );
  }
}
