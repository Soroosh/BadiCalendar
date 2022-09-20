import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/tabs/feasts.dart';
import 'package:badi_calendar/tabs/full_date.dart';
import 'package:badi_calendar/tabs/holy_day.dart';
import 'package:badi_calendar/tabs/settings.dart';
import 'package:badi_calendar/widget/intro_dialog.dart';
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

class HomePage extends StatefulWidget {
  final ConfigurationProvider _configurationProvider;
  final void Function(String language) onLanguageChange;
  HomePage(this._configurationProvider, this.onLanguageChange, {Key? key})
      : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _initConfiguration();
  }

  Future<void> _initConfiguration() async {
    await widget._configurationProvider.readFromSharedPreferences();
    setState(() {});
    _showIntroDialog(
        widget._configurationProvider.configuration.seenDialogVersion);
  }

  void _showIntroDialog(int seenVersion) {
    if (seenVersion < LASTEST_DIALOG_VERSION && mounted) {
      showDialog(
          context: context,
          builder: (context) {
            return IntroDialog(
                widget._configurationProvider, widget.onLanguageChange);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.appName ?? ''),
        bottom: TabBar(
          tabs: [
            Tab(text: l10n?.fullDate ?? ''),
            Tab(text: l10n?.feasts ?? ''),
            Tab(text: l10n?.holyDayTab ?? '')
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: widget._configurationProvider.listenToConfiguration,
        builder: (BuildContext context, Configuration configuration,
            Widget? widget) {
          return TabBarView(children: [
            FullDate(config: configuration),
            Feasts(config: configuration),
            HolyDay(config: configuration),
          ]);
        },
      ),
    );
  }
}
