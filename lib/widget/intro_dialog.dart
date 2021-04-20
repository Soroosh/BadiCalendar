import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/widget/location_setting.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'date_format_setting.dart';
import 'language_setting.dart';

class IntroDialog extends StatefulWidget {
  final ConfigurationProvider _configurationProvider;
  final void Function(String) onLanguageChange;

  const IntroDialog(
    this._configurationProvider,
    this.onLanguageChange, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return IntroDialogState();
  }
}

class IntroDialogState extends State<IntroDialog> {
  late final int _initPage;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage =
        widget._configurationProvider.configuration.seenDialogVersion + 1;
    _initPage = widget._configurationProvider.configuration.seenDialogVersion;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return Container();
    }
    return SimpleDialog(
      title: _buildTitle(l10n),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
      children: [
        _buildContent(l10n),
        _buildActions(l10n),
      ],
    );
  }

  Widget _buildActions(AppLocalizations l10n) {
    final isLastPage = _currentPage == LASTEST_DIALOG_VERSION;
    final page =
        '${_currentPage - _initPage}/${LASTEST_DIALOG_VERSION - _initPage}';
    // final theme = Theme.of(context);
    return Row(children: [
      Text(page),
      Spacer(),
      TextButton(
        onPressed: () {
          widget._configurationProvider
              .saveSeenDialogVersion(LASTEST_DIALOG_VERSION);
          Navigator.of(context).pop();
        },
        child: Text(l10n.skip),
      ),
      SizedBox(width: 32),
      TextButton(
        onPressed: () {
          widget._configurationProvider.saveSeenDialogVersion(_currentPage);
          setState(() {
            _currentPage++;
          });
          if (isLastPage) {
            Navigator.of(context).pop();
          }
        },
        child: Text(isLastPage ? l10n.fin : l10n.next),
      ),
    ]);
  }

  Widget _buildTitle(AppLocalizations l10n) {
    if (_currentPage == 1) {
      return Text(l10n.selectLanguage);
    }
    return Text(l10n.selectLocationMethod);
  }

  Widget _buildContent(AppLocalizations l10n) {
    if (_currentPage == 1) {
      return _buildLanguageAndDateFormat(l10n);
    }
    return _buildLocation(l10n);
  }

  Widget _buildLanguageAndDateFormat(AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.languageSettingsTitle,
          style: theme.textTheme.subtitle1,
        ),
        LanguageSetting(widget._configurationProvider, widget.onLanguageChange),
        Text(l10n.dateFormat, style: theme.textTheme.subtitle1),
        DateFormatSetting(widget._configurationProvider),
      ],
    );
  }

  Widget _buildLocation(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.locationDescription),
        LocationSetting(widget._configurationProvider),
      ],
    );
  }
}
