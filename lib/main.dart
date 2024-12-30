import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/pages/home.dart';
import 'package:badi_calendar/pages/settings.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigurationProvider();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String? language;
  final ConfigurationProvider _configurationProvider = ConfigurationProvider();

  void onLanguageChange(String lang) {
    setState(() {
      language = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController(
      length: 3,
      child: HomePage(_configurationProvider, onLanguageChange),
    );
    final routes = <String, WidgetBuilder>{
      '/settings': (BuildContext context) =>
          Settings(_configurationProvider, onLanguageChange),
    };
    final locale = language;
    return MaterialApp(
      title: 'Badi-Calendar',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      highContrastTheme:
          ThemeData.from(colorScheme: ColorScheme.highContrastLight()),
      highContrastDarkTheme:
          ThemeData.from(colorScheme: ColorScheme.highContrastDark()),
      themeMode: ThemeMode.system,
      home: tabController,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: routes,
      localeListResolutionCallback: (deviceLocale, supportedLocales) {
        if (locale == null) {
          return deviceLocale?.first;
        }
        return Locale(locale);
      },
      locale: locale != null ? Locale(locale) : null,
    );
  }
}
