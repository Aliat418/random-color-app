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
