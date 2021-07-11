import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badi_calendar/model/configuration.dart';
import 'package:mockito/mockito.dart';

Widget wrapWidget(Widget widget) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: widget));

class FakeConfigurationProvider extends Fake implements ConfigurationProvider {
  int listenerCount = 0;
  List<String> invocations = [];
  List<dynamic> arguments = [];

  @override
  ValueNotifier<Configuration> get listenToConfiguration {
    listenerCount++;
    return ValueNotifier(Configuration());
  }

  @override
  Configuration get configuration => Configuration(
        seenDialogVersion: 0,
        locationMethod: LocationMethod.AUTOMATIC,
      );

  @override
  Future<void> saveHideSunsetInDates(bool? value) async {
    invocations.add('saveHideSunsetInDates');
    arguments.add(value);
  }

  @override
  Future<void> saveDateFormat(int value) async {
    invocations.add('saveDateFormat');
    arguments.add(value);
  }

  @override
  Future<void> saveSeenDialogVersion(int value) async {
    invocations.add('saveSeenDialogVersion');
    arguments.add(value);
  }

  @override
  Future<void> changeLocationMethod(LocationMethod value) async {
    invocations.add('changeLocationMethod');
    arguments.add(value);
  }
}
