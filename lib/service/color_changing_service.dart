import 'dart:math';

import 'package:injectable/injectable.dart';

import '../model/app_color.dart';

class ColorUtils {
  static const maxRgbValue = 255;
  static const luminanceThreshold = 0.46;
  static const luminanceWeights = (
    red: 0.299,
    green: 0.587,
    blue: 0.114,
  );

  static double calculateLuminance(AppColor color) {
    return (luminanceWeights.red * color.red +
            luminanceWeights.green * color.green +
            luminanceWeights.blue * color.blue) /
        255;
  }

  static AppColor getAccessibleColor(AppColor backgroundColor) {
    final luminance = calculateLuminance(AppColor.fromRGBO(
      red: backgroundColor.red,
      green: backgroundColor.green,
      blue: backgroundColor.blue,
    ));
    return luminance > luminanceThreshold ? AppColor.dark() : AppColor.light();
  }
}

abstract class ColorService {
  AppColor generateRandomColor();

  AppColor selectAccessibleColor(AppColor backgroundColor) {
    return ColorUtils.getAccessibleColor(backgroundColor);
  }
}

@named
@Singleton(as: ColorService)
class SimpleRandomColorService extends ColorService {
  final Random _random = Random.secure();

  @override
  AppColor generateRandomColor() => AppColor(
        red: _random.nextInt(256),
        green: _random.nextInt(256),
        blue: _random.nextInt(256),
      );
}

@singleton
class ColorRepository {
  final ColorService _colorService;

  ColorRepository({
    @Named.from(SimpleRandomColorService) required ColorService colorService,
  }) : _colorService = colorService;

  AppColor generateRandomColor() {
    return _colorService.generateRandomColor();
  }

  AppColor selectAccessibleColor(AppColor backgroundColor) {
    return _colorService.selectAccessibleColor(backgroundColor);
  }
}
