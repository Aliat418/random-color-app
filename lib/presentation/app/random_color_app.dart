import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../color_changing_page/color_changing_page.dart';

class RandomColorApp extends StatelessWidget {
  const RandomColorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(useMaterial3: true),
      home: Builder(
        builder: (_) => const ColorChangingScreen(),
      ),
    );
  }
}
