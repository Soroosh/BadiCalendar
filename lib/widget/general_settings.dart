import 'package:badi_calendar/l10n/app_localizations.dart';
import 'package:badi_calendar/model/configuration.dart';
import 'package:flutter/material.dart';

class HideSunsetTimesSetting extends StatelessWidget {
  final ConfigurationProvider _configurationProvider;

  const HideSunsetTimesSetting(this._configurationProvider, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ValueListenableBuilder(
        valueListenable: _configurationProvider.listenToConfiguration,
        builder: (BuildContext context, Configuration configuration,
            Widget? widget) {
          return ListTile(
            onTap: () => _configurationProvider.saveHideSunsetInDates(
                !_configurationProvider.configuration.hideSunsetInDates),
            title: Text(l10n.hideSunsetInDates),
            leading: Checkbox(
              value: _configurationProvider.configuration.hideSunsetInDates,
              onChanged: (value) =>
                  _configurationProvider.saveHideSunsetInDates(value),
            ),
          );
        });
  }
}
