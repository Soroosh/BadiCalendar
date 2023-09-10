import 'package:badi_calendar/model/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationSetting extends StatefulWidget {
  final ConfigurationProvider _configurationProvider;

  const LocationSetting(this._configurationProvider, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LocationSettingState();
  }
}

class LocationSettingState extends State<LocationSetting> {
  final _longitudeController = TextEditingController();
  final _latitudeController = TextEditingController();
  bool _longitudeHasError = false;
  bool _latitudeHasError = false;

  @override
  void initState() {
    super.initState();
    setFields();
  }

  Future<void> setFields() async {
    _longitudeController.text =
        widget._configurationProvider.configuration.longitude?.toString() ?? '';
    _latitudeController.text =
        widget._configurationProvider.configuration.latitude?.toString() ?? '';
  }

  void _saveLocationMethod(LocationMethod? value) {
    if (value == null) return;
    widget._configurationProvider.changeLocationMethod(value);
    if (value == LocationMethod.MANUEL) setFields();
    setState(() {});
  }

  void _saveLatitude(String value) {
    try {
      final l = double.parse(value.replaceAll(',', '.'));
      widget._configurationProvider.saveLatitude(l);
      setState(() {
        _latitudeHasError = false;
      });
    } catch (e) {
      setState(() {
        _latitudeHasError = true;
      });
    }
  }

  void _saveLongitude(String value) {
    try {
      final l = double.parse(value.replaceAll(',', '.'));
      widget._configurationProvider.saveLongitude(l);
      setState(() {
        _longitudeHasError = false;
      });
    } catch (e) {
      setState(() {
        _longitudeHasError = true;
      });
    }
  }

  Widget _buildLocationInput(Configuration configuration) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 70),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Focus(
              child: TextField(
                controller: _longitudeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n?.longitude,
                  errorText: _longitudeHasError ? l10n?.locationError : null,
                ),
                onSubmitted: _saveLongitude,
              ),
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  _saveLongitude(_longitudeController.text);
                }
              }),
          Text(l10n?.longitudeHelper ?? '', style: theme.textTheme.bodySmall),
          SizedBox(height: 5),
          Focus(
            child: TextField(
              controller: _latitudeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n?.latitude,
                errorText: _latitudeHasError ? l10n?.locationError : null,
              ),
              onSubmitted: _saveLatitude,
            ),
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                _saveLatitude(_latitudeController.text);
              }
            },
          ),
          Text(l10n?.latitudeHelper ?? '', style: theme.textTheme.bodySmall),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ValueListenableBuilder(
      valueListenable: widget._configurationProvider.listenToConfiguration,
      builder:
          (BuildContext context, Configuration configuration, Widget? widget) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (final method in LocationMethod.values)
            Column(children: [
              ListTile(
                onTap: () => _saveLocationMethod(method),
                title: Text(l10n?.locationSettingsMethod(method.index) ?? ''),
                leading: Radio(
                  groupValue: configuration.locationMethod,
                  onChanged: _saveLocationMethod,
                  value: method,
                ),
              ),
              if (configuration.locationMethod == LocationMethod.MANUEL &&
                  method == LocationMethod.MANUEL)
                _buildLocationInput(configuration),
            ]),
        ]);
      },
    );
  }
}
