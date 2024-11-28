import 'dart:math';

import 'package:injectable/injectable.dart';

import '../../domain/model/app_color.dart';
import 'color_changing_service.dart';

@named
@Singleton(as: ColorChangingService)
class SimpleColorChangingService extends ColorChangingService {
  // Use .secure() to be truly random
  final Random _random;

  // Use seed for testing purposes
  SimpleColorChangingService({int? seed}) : _random = Random(seed);

  @override
  Future<AppColor> generateRandomColor() async => AppColor(
        red: _random.nextInt(256),
        green: _random.nextInt(256),
        blue: _random.nextInt(256),
      );
}
