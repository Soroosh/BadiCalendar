import 'package:badi_calendar/model/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badi_calendar/model/names.dart';

class LanguageSetting extends StatelessWidget {
  final ConfigurationProvider _configurationProvider;
  final void Function(String) onLanguageChange;

  const LanguageSetting(this._configurationProvider, this.onLanguageChange,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
        valueListenable: _configurationProvider.listenToConfiguration,
        builder: (BuildContext context, Configuration configuration,
            Widget? widget) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: DropdownButton<String>(
                value: configuration.language ??
                    Localizations.localeOf(context).languageCode,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: theme.accentColor,
                ),
                onChanged: (String? newValue) {
                  if (newValue == null) return;
                  _configurationProvider.saveLanguage(newValue);
                  onLanguageChange(newValue);
                },
                items: AppLocalizations.supportedLocales.map((value) {
                  return DropdownMenuItem(
                    value: value.languageCode,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(LANGUAGES[value.languageCode] ?? ''),
                    ),
                  );
                }).toList(),
              ));
        });
  }
}
