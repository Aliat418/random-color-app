import 'package:flutter/material.dart';

import 'core/infrastructure/di.dart';
import 'presentation/app/random_color_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const RandomColorApp());
}
