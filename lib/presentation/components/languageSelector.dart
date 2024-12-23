import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telescope_phone_v2/core/extensions/translation_extension/Translation_extension.dart';
import '../../app_localizations.dart';
import '../../data/cubits/local_cubit/local_cubit.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.language_outlined),
      title: Text((context).trans('Language')),
      onTap: () => _showLanguageDialog(context),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: AppLocalizations.supportedLocales().map((Locale locale) {
                return ListTile(
                  title: Text(locale.languageCode == 'en' ? 'English' : 'Arabic'),
                  onTap: () {
                    if (locale.languageCode == 'ar') {
                      context.read<LocaleCubit>().toArabic();
                    } else {
                      context.read<LocaleCubit>().toEnglish();
                    }
                    Navigator.of(context).pop(); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {  Navigator.of(context).pop(); },
              child: Text((context).trans("Cancel"),style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        );
      },
    );
  }
}
