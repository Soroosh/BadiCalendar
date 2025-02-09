import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/model/names.dart';
import 'package:badi_calendar/widget/date_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:badi_date/badi_date.dart';
import 'package:intl/intl.dart';

class Feasts extends StatefulWidget {
  final Configuration config;

  const Feasts({super.key, required this.config});

  @override
  State<StatefulWidget> createState() {
    return FeastsState();
  }
}

class FeastsState extends State<Feasts> {
  final _controller = ScrollController();
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
    var f = NumberFormat("###", widget.config.language);
    final List<Widget> days = [];
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
          key: Key('FeastYear$year'),
          f.format(year),
          style: Theme.of(context).textTheme.headlineMedium,
        ));
      }
      while (badiDate.year == year) {
        if (_now.isBefore(badiDate.endDateTime)) {
          days.add(FeastCard(config: widget.config, badiDate: badiDate));
        }
        badiDate = badiDate.getNextFeast();
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
    final today = BadiDate.fromDate(
      _now,
      longitude: widget.config.longitude,
      latitude: widget.config.latitude,
      altitude: widget.config.altitude,
    );
    return Stack(children: [
      SelectionArea(
        child: ListView.builder(
          key: Key('FeastListView'),
          controller: _controller,
          padding: EdgeInsets.all(10),
          itemCount: 19 * (BadiDate.LAST_YEAR_SUPPORTED - today.year),
          itemBuilder: (BuildContext context, int index) {
            final year = index + today.year;
            try {
              return _buildYear(context, year);
            } catch (_) {
              return Container();
            }
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

class FeastCard extends StatelessWidget {
  final Configuration config;
  final BadiDate badiDate;

  const FeastCard({
    super.key,
    required this.config,
    required this.badiDate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final language = Localizations.localeOf(context).languageCode;
    final monthOriginal = l10n?.showOriginal != "false"
        ? '${MONTH_NAMES[badiDate.month]} - '
        : '';
    final monthTranslation =
        MONTH_NAME_TRANSLATIONS[language]?[badiDate.month] ?? '';
    final month = '$monthOriginal$monthTranslation';
    return DateCard(
      key: Key('Feast_${badiDate.year}_${badiDate.month}'),
      title: month,
      date: badiDate,
      dateFormatIndex: config.dateFormatIndex,
      hideSunsetTimes: config.hideSunsetInDates,
    );
  }
}
