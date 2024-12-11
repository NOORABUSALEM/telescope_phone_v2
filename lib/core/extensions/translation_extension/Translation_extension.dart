
import 'package:flutter/cupertino.dart';

import '../../../app_localizations.dart';


extension Translation on BuildContext {
  String trans(String x) {
    final localizations =
    Localizations.of<AppLocalizations>(this, AppLocalizations);
    if (localizations != null) {
      return localizations.translate(x);
    } else {
      return x;
    }
  }
}
