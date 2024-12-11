import 'dart:ui';

abstract class LocalState {}

class SelectedLocale extends LocalState {
  final Locale locale;

  SelectedLocale(this.locale);
}
