import 'package:badi_calendar/model/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateFormatSetting extends StatelessWidget {
  final ConfigurationProvider _configurationProvider;

  const DateFormatSetting(this._configurationProvider, {Key? key})
      : super(key: key);

  void _saveDateFormatIndex(int? value) {
    if (value == null) return;
    _configurationProvider.saveDateFormat(value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ValueListenableBuilder(
        valueListenable: _configurationProvider.listenToConfiguration,
        builder: (BuildContext context, Configuration configuration,
            Widget? widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final i in [0, 1, 2])
                ListTile(
                  onTap: () => _saveDateFormatIndex(i),
                  title: Text(l10n?.dateFormatFromIndex(i) ?? ''),
                  leading: Radio(
                    groupValue: configuration.dateFormatIndex,
                    onChanged: _saveDateFormatIndex,
                    value: i,
                  ),
                ),
            ],
          );
        });
  }
}
