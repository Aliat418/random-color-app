import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Random Color App';

  @override
  String get helloThere => 'Hello there';

  @override
  String colorsChanged(int count) {
    return 'Colors changed: $count';
  }
}
