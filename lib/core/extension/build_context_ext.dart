import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
