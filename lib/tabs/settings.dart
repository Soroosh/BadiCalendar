import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/widget/date_format_setting.dart';
import 'package:badi_calendar/widget/general_settings.dart';
import 'package:badi_calendar/widget/language_setting.dart';
import 'package:badi_calendar/widget/location_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  final ConfigurationProvider _configurationProvider;
  final void Function(String) onLanguageChange;

  const Settings(this._configurationProvider, this.onLanguageChange,
      {super.key});

  Widget _buildSettingGroup(
      BuildContext context, List<Widget> settings, String title) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge,
        ),
        ...settings,
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return Container();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.settingsTitle ?? ''),
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
          child: ListView(
            children: <Widget>[
              _buildSettingGroup(
                context,
                [LocationSetting(_configurationProvider)],
                l10n.locationSettingsTitle,
              ),
              _buildSettingGroup(
                context,
                [LanguageSetting(_configurationProvider, onLanguageChange)],
                l10n.languageSettingsTitle,
              ),
              _buildSettingGroup(
                context,
                [
                  DateFormatSetting(_configurationProvider),
                  HideSunsetTimesSetting(_configurationProvider),
                ],
                l10n.dateFormat,
              ),
            ],
          ),
        ));
  }
}
