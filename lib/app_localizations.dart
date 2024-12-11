import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  static Map<String, String>? _localizedStrings;

  AppLocalizations(this.locale);

  static Future<AppLocalizations> load(Locale locale) async {
    String jsonString =
        await rootBundle.loadString('lib/l10n/${locale.languageCode}.json');
    _localizedStrings = json.decode(jsonString).cast<String, String>();
    return AppLocalizations(locale);
  }

  String translate(String key) {
    return _localizedStrings![key]!;
  }

  static List<Locale> supportedLocales() {
    return [Locale('en', ''), Locale('ar', '')];
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales().contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
