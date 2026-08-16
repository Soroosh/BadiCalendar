import 'package:badi_calendar/l10n/app_localizations.dart';
import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/model/names.dart';
import 'package:badi_calendar/widget/date_card.dart';
import 'package:flutter/material.dart';

import 'package:badi_date/badi_date.dart';
import 'package:intl/intl.dart';

class HolyDay extends StatefulWidget {
  final Configuration config;

  const HolyDay({super.key, required this.config});

  @override
  State<StatefulWidget> createState() {
    return HolyDayState();
  }
}

class HolyDayState extends State<HolyDay> {
  final ScrollController _controller = ScrollController();
  final _now = DateTime.now();
  bool _hasScrolled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge == _hasScrolled) {
        setState(() {
          _hasScrolled = !_controller.position.atEdge;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _buildFAB(BuildContext context) {
    return _hasScrolled
        ? FloatingActionButton(
            onPressed: () {
              _controller.animateTo(
                0,
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
              );
            },
            child: Icon(Icons.arrow_upward),
          )
        : Container();
  }

  Widget _buildYear(BuildContext context, int year) {
    final List<Widget> days = [];
    var f = NumberFormat("###", widget.config.language);
    try {
      BadiDate badiDate = BadiDate(
        year: year,
        month: 1,
        day: 1,
        longitude: widget.config.longitude,
        latitude: widget.config.latitude,
        altitude: widget.config.altitude,
      );
      if (badiDate.endDateTime.isAfter(_now)) {
        days.add(Text(
          f.format(year),
          key: Key('HolyDaysYear$year'),
          style: Theme.of(context).textTheme.headlineMedium,
        ));
      } else {
        days.add(Text(
          AppLocalizations.of(context)?.upcoming ?? '',
          key: Key('HolyDaysExplanation'),
        ));
      }
      final lastAyyamIHa = badiDate.lastAyyamIHaDayOfYear;
      while (badiDate.year == year) {
        if (_now.isBefore(badiDate.endDateTime)) {
          days.add(HolyDayCard(config: widget.config, badiDate: badiDate));
        }
        badiDate = badiDate.nextHolyDate;
      }
      if (_now.isBefore(lastAyyamIHa.endDateTime)) {
        days.add(AyyamIHaCard(config: widget.config, badiDate: lastAyyamIHa));
      }
    } catch (_) {
      // continue
    }
    return Column(
      children: days,
    );
  }

  @override
  Widget build(BuildContext context) {
    final badiNow = BadiDate.fromDate(
      _now,
      longitude: widget.config.longitude,
      latitude: widget.config.latitude,
      altitude: widget.config.altitude,
    );
    return Stack(children: [
      SelectionArea(
        child: ListView.builder(
          key: Key('HolyDayListView'),
          padding: EdgeInsets.all(10),
          controller: _controller,
          itemCount: BadiDate.LAST_YEAR_SUPPORTED - badiNow.year,
          itemBuilder: (BuildContext context, int index) {
            return _buildYear(context, badiNow.year + index);
          },
        ),
      ),
      Positioned(
        bottom: 25,
        right: 25,
        child: _buildFAB(context),
      ),
    ]);
  }
}

class HolyDayCard extends StatelessWidget {
  final Configuration config;
  final BadiDate badiDate;

  const HolyDayCard({
    super.key,
    required this.config,
    required this.badiDate,
  });

  @override
  Widget build(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    final holyDay = HOLY_DAYS[language]?[badiDate.holyDay] ?? '';
    return DateCard(
      key: Key('HolyDay_${badiDate.year}_$holyDay'),
      title: holyDay,
      date: badiDate,
      dateFormatIndex: config.dateFormatIndex,
      hideSunsetTimes: config.hideSunsetInDates,
    );
  }
}

class AyyamIHaCard extends StatelessWidget {
  final Configuration config;
  final BadiDate badiDate;

  const AyyamIHaCard({
    super.key,
    required this.config,
    required this.badiDate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final start = BadiDate(
      year: badiDate.year,
      day: 1,
      ayyamIHa: true,
      longitude: config.longitude,
      latitude: config.latitude,
      altitude: config.altitude,
    );
    return DateCard(
      key: Key('HolyDay_${badiDate.year}_ayyamiha'),
      title: l10n.ayyamiha,
      date: badiDate,
      ayyamIHaStart: start,
      dateFormatIndex: config.dateFormatIndex,
      hideSunsetTimes: config.hideSunsetInDates,
    );
  }
}
