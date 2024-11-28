import 'package:flutter/material.dart';

import 'presentation/app/random_color_app.dart';
import 'core/infrastructure/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const RandomColorApp());
}
