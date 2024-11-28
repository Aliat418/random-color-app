import '../../core/util/app_color_util.dart';
import '../../domain/model/app_color.dart';

mixin AccessibleColorMixin {
  Future<AppColor> selectAccessibleColor(AppColor backgroundColor) async {
    return ColorUtil.getAccessibleColor(backgroundColor);
  }
}
