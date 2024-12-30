import 'dart:math' as math;
import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/tabs/feasts.dart';
import 'package:badi_calendar/tabs/full_date.dart';
import 'package:badi_calendar/tabs/holy_day.dart';
import 'package:badi_calendar/widget/intro_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const double breakWidth = 800;

class HomePage extends StatefulWidget {
  final ConfigurationProvider _configurationProvider;
  final void Function(String language) onLanguageChange;
  HomePage(this._configurationProvider, this.onLanguageChange, {super.key});

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
    final bool smallerBreak = MediaQuery.sizeOf(context).width < breakWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.appName ?? ''),
        bottom: smallerBreak
            ? TabBar(
                tabs: [
                  Tab(text: l10n?.fullDate ?? ''),
                  Tab(text: l10n?.feasts ?? ''),
                  Tab(text: l10n?.holyDayTab ?? '')
                ],
              )
            : null,
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
          return smallerBreak
              ? TabBarView(children: [
                  FullDate(config: configuration),
                  Feasts(config: configuration),
                  HolyDay(config: configuration),
                ])
              : SinglePage(config: configuration);
        },
      ),
    );
  }
}

class SinglePage extends StatefulWidget {
  final Configuration config;

  const SinglePage({super.key, required this.config});

  @override
  State<StatefulWidget> createState() {
    return SinglePageState();
  }
}

class SinglePageState extends State<SinglePage> {
  final _controller = ScrollController();
  final _controllerFeast = ScrollController();
  final _controllerHolyDays = ScrollController();
  final _now = DateTime.now();
  bool showAccordionFab = true;

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _controller.animateTo(
          0,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        _controllerFeast.animateTo(
          0,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        _controllerHolyDays.animateTo(
          0,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        setState(() {
          showAccordionFab = true;
        });
      },
      child: Icon(Icons.arrow_upward),
    );
  }

  Widget _buildFAB2(BuildContext context, double height) {
    return showAccordionFab
        ? FloatingActionButton(
            onPressed: () {
              _controller.animateTo(
                height,
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
              );
              setState(() {
                showAccordionFab = false;
              });
            },
            child: Icon(Icons.arrow_downward),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height - 100;
    final double fullDateHeight = math.min(screenHeight, 500);
    return Stack(children: [
      ListView(
        shrinkWrap: false,
        key: Key('FeastListView'),
        controller: _controller,
        children: [
          SizedBox(
            height: fullDateHeight,
            child: FullDate(
              config: widget.config,
            ),
          ),
          SizedBox(
            height: screenHeight,
            child: Row(
              children: [
                Expanded(
                  child: FeastsList(
                    config: widget.config,
                    controller: _controllerFeast,
                    now: _now,
                  ),
                ),
                Expanded(
                  child: HolyDayList(
                    config: widget.config,
                    controller: _controllerHolyDays,
                    now: _now,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Positioned(
        bottom: 25,
        right: 25,
        child: _buildFAB(context),
      ),
      Positioned(
        top: 25,
        right: 25,
        child: _buildFAB2(context, fullDateHeight),
      ),
    ]);
  }
}
