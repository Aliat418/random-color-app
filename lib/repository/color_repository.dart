import 'package:injectable/injectable.dart';

import '../model/app_color.dart';
import '../service/color_changing_service.dart';

@singleton
class ColorRepository {
  final ColorChangingService _simpleColorService;
  // ignore: unused_field
  final ColorChangingService _customColorService;

  ColorRepository({
    @Named.from(SimpleColorChangingService)
    required ColorChangingService simpleColorService,
    @Named.from(CustomColorChangingService)
    required ColorChangingService customColorService,
  })  : _simpleColorService = simpleColorService,
        _customColorService = customColorService;

  Future<AppColor> generateRandomColor() async {
    return _simpleColorService.generateRandomColor();
  }

  Future<AppColor> selectAccessibleColor(AppColor backgroundColor) async {
    return _simpleColorService.selectAccessibleColor(backgroundColor);
  }
}
