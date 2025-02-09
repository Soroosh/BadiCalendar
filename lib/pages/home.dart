import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/tabs/feasts.dart';
import 'package:badi_calendar/tabs/full_date.dart';
import 'package:badi_calendar/tabs/holy_day.dart';
import 'package:badi_calendar/widget/date_card.dart';
import 'package:badi_calendar/widget/intro_dialog.dart';
import 'package:flutter/material.dart';

import 'package:badi_date/badi_date.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

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
  final _now = DateTime.now();
  DateTime _fullDate = DateTime.now();
  bool showAccordionFab = true;

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _controller.animateTo(
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

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsetsDirectional.only(start: 20, end: 20),
        child: SelectionArea(
          child: CustomScrollView(
            controller: _controller,
            key: Key('single-page'),
            slivers: [
              FullDateList(
                asSliver: true,
                config: widget.config,
                dateTime: _fullDate,
                datePicker: FloatingDatePicker(
                    dateTime: _fullDate, onDatePicked: onDatePicked),
              ),
              FeastAndHolyDaysList(
                config: widget.config,
                now: _now,
              )
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 25,
        right: 25,
        child: _buildFAB(context),
      ),
    ]);
  }

  void onDatePicked(DateTime newDate) {
    setState(() {
      _fullDate = DateTime(newDate.year, newDate.month, newDate.day,
          _fullDate.hour, _fullDate.minute);
    });
  }
}

class FeastAndHolyDaysList extends StatelessWidget {
  final Configuration config;
  final DateTime now;

  const FeastAndHolyDaysList({
    super.key,
    required this.config,
    required this.now,
  });

  Widget _buildYear(BuildContext context, int year) {
    final List<Widget> days = [];
    final l10n = AppLocalizations.of(context);
    var f = NumberFormat("###", config.language);
    try {
      BadiDate badiDate = BadiDate(
        year: year,
        month: 1,
        day: 1,
        longitude: config.longitude,
        latitude: config.latitude,
        altitude: config.altitude,
      );
      if (badiDate.endDateTime.isAfter(now)) {
        days.add(Text(
          f.format(year),
          key: Key('Year$year'),
          style: Theme.of(context).textTheme.headlineMedium,
        ));
      } else {
        days.add(_buildRow(
            Card(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Container(
                alignment: Alignment.center,
                width: DATE_CARD_WIDTH,
                padding: EdgeInsets.all(8),
                child: Text(
                  l10n?.holyDayTab ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Card(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Container(
                    alignment: Alignment.center,
                    width: DATE_CARD_WIDTH,
                    padding: EdgeInsets.all(8),
                    child: Text(
                      l10n?.feasts ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    )))));
        days.add(_buildRow(
          Text(AppLocalizations.of(context)?.upcoming ?? '',
              key: Key('HolyDaysExplanation')),
          SizedBox(width: DATE_CARD_WIDTH),
        ));
      }

      final lastAyyamIHa = badiDate.lastAyyamIHaDayOfYear;
      while (badiDate.year == year) {
        if (badiDate.endDateTime.isAfter(lastAyyamIHa.startDateTime) &&
            now.isBefore(lastAyyamIHa.endDateTime)) {
          days.add(_buildRow(
              AyyamIHaCard(config: config, badiDate: lastAyyamIHa),
              SizedBox(
                width: DATE_CARD_WIDTH,
              )));
        }
        if (now.isBefore(badiDate.endDateTime)) {
          days.add(
            _buildRow(
                badiDate.holyDay != null
                    ? HolyDayCard(config: config, badiDate: badiDate)
                    : SizedBox(
                        width: DATE_CARD_WIDTH,
                      ),
                badiDate.isFeastDay
                    ? FeastCard(config: config, badiDate: badiDate)
                    : SizedBox(
                        width: DATE_CARD_WIDTH,
                      )),
          );
        }
        final badiDateHD = badiDate.nextHolyDate;
        final badiDateFeast = badiDate.getNextFeast();
        if (badiDateFeast.endDateTime.isAfter(badiDateHD.endDateTime)) {
          badiDate = badiDateHD;
        } else {
          badiDate = badiDateFeast;
        }
      }
    } catch (_) {
      // continue
    }
    return Column(
      children: days,
    );
  }

  Widget _buildRow(Widget? holyday, Widget? feast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        holyday ??
            SizedBox(
              width: DATE_CARD_WIDTH,
            ),
        SizedBox(width: 32),
        feast ??
            SizedBox(
              width: DATE_CARD_WIDTH,
            )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final badiNow = BadiDate.fromDate(
      now,
      longitude: config.longitude,
      latitude: config.latitude,
      altitude: config.altitude,
    );
    return SliverList.builder(
      key: Key('HolyDayListView'),
      itemCount: BadiDate.LAST_YEAR_SUPPORTED - badiNow.year,
      itemBuilder: (BuildContext context, int index) {
        return _buildYear(context, badiNow.year + index);
      },
    );
  }
}
