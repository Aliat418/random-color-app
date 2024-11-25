import 'package:flutter/material.dart';

import 'infrastructure/di.dart';
import 'random_color_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const RandomColorApp());
}
