import '../../domain/model/app_color.dart';
import 'accessible_color_mixin.dart';

abstract class ColorChangingService with AccessibleColorMixin {
  Future<AppColor> generateRandomColor();
}
