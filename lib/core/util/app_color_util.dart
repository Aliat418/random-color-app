import '../../domain/model/app_color.dart';

class ColorUtil {
  static const maxRgbValue = 255;
  static const luminanceThreshold = 0.46;
  static const luminanceWeights = (
    red: 0.299,
    green: 0.587,
    blue: 0.114,
  );

  static Future<double> calculateLuminance(AppColor color) async {
    return (luminanceWeights.red * color.red +
            luminanceWeights.green * color.green +
            luminanceWeights.blue * color.blue) /
        255;
  }

  static Future<AppColor> getAccessibleColor(AppColor backgroundColor) async {
    final luminance = await calculateLuminance(AppColor.fromRGBO(
      red: backgroundColor.red,
      green: backgroundColor.green,
      blue: backgroundColor.blue,
    ));
    return luminance > luminanceThreshold ? AppColor.dark() : AppColor.light();
  }
}
