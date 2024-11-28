import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../domain/model/app_color.dart';
import 'color_changing_service.dart';

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
