import 'package:badi_calendar/l10n/app_localizations.dart';
import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/model/names.dart';
import 'package:badi_calendar/model/utils.dart';
import 'package:flutter/material.dart';
import 'package:dart_suncalc/suncalc.dart';

import 'package:badi_date/badi_date.dart';

const MAX_WIDTH = 600.0;

class FullDate extends StatefulWidget {
  final Configuration config;

  const FullDate({super.key, required this.config});

  @override
  State<StatefulWidget> createState() {
    return FullDateState();
  }
}

class FullDateState extends State<FullDate> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.all(20),
        child: SelectionArea(
          child: FullDateList(
            config: widget.config,
            dateTime: _dateTime,
          ),
        ),
      ),
      Positioned(
        bottom: 25,
        right: 25,
        child:
            FloatingDatePicker(dateTime: _dateTime, onDatePicked: onDatePicked),
      ),
    ]);
  }

  void onDatePicked(DateTime newDate) {
    setState(() {
      _dateTime = DateTime(newDate.year, newDate.month, newDate.day,
          _dateTime.hour, _dateTime.minute);
    });
  }
}

class FloatingDatePicker extends StatelessWidget {
  final DateTime dateTime;
  final void Function(DateTime newDate) onDatePicked;

  const FloatingDatePicker(
      {super.key, required this.dateTime, required this.onDatePicked});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FloatingActionButton(
      onPressed: () async {
        final newDate = await showDatePicker(
          context: context,
          initialDate: dateTime,
          firstDate: DateTime(1844, 5, 23),
          lastDate: DateTime(1844 + BadiDate.LAST_YEAR_SUPPORTED, 3, 19),
          confirmText: l10n?.ok,
          cancelText: l10n?.cancel,
          helpText: l10n?.selectADate,
          locale: Localizations.localeOf(context),
        );
        if (newDate != null && newDate != dateTime) {
          onDatePicked(newDate);
        }
      },
      child: Icon(Icons.calendar_today),
    );
  }
}

class FullDateList extends StatelessWidget {
  final Configuration config;
  final DateTime dateTime;
  final bool asSliver;
  final Widget? datePicker;

  const FullDateList(
      {super.key,
      required this.config,
      required this.dateTime,
      this.datePicker,
      this.asSliver = false});

  Widget _buildHolydayInfo(
      BuildContext context, BadiDate badiDate, AppLocalizations l10n) {
    if (badiDate.holyDay == null) return Container();
    final textTheme = Theme.of(context).textTheme;
    final language = Localizations.localeOf(context).languageCode;
    final holyDay = HOLY_DAYS[language]?[badiDate.holyDay] ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sizedBox(),
        Text(
          l10n.specialDay,
          style: textTheme.titleMedium,
        ),
        Text(
          holyDay,
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildDayOfTheWeek(
      BuildContext context, BadiDate badiDate, AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    final dayIndex = dateTime.weekday;
    final dayOriginal =
        l10n.showOriginal != "false" ? '${WEEK_DAY[dayIndex]} - ' : '';
    final language = Localizations.localeOf(context).languageCode;
    final dayTranslation = WEEK_DAY_TRANSLATION[language]?[dayIndex] ?? '';
    final day = '$dayOriginal$dayTranslation';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        l10n.weekDayTitle,
        style: textTheme.titleMedium,
      ),
      Text(
        l10n.dayOfTheWeek(day),
        style: textTheme.bodyLarge,
      ),
    ]);
  }

  Widget _buildMonthAndDay(
      BuildContext context, BadiDate badiDate, AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    final language = Localizations.localeOf(context).languageCode;
    final dayOriginal =
        l10n.showOriginal != "false" ? '${MONTH_NAMES[badiDate.day]} - ' : '';
    final dayTranslation =
        MONTH_NAME_TRANSLATIONS[language]?[badiDate.day] ?? '';
    final day = '$dayOriginal$dayTranslation';
    final monthOriginal =
        l10n.showOriginal != "false" ? '${MONTH_NAMES[badiDate.month]} - ' : '';
    final monthTranslation =
        MONTH_NAME_TRANSLATIONS[language]?[badiDate.month] ?? '';
    final month = '$monthOriginal$monthTranslation';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.dayAndMonthTitle,
          style: textTheme.titleMedium,
        ),
        if (badiDate.day == 1) Text(l10n.feastHint),
        Container(
          constraints: BoxConstraints(maxWidth: MAX_WIDTH),
          child: Text(l10n.dayAndMonthExplanation, style: textTheme.bodySmall),
        ),
        Text(
          l10n.dayAndMonth(month, day),
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildVahidAndYear(
      BuildContext context, BadiDate badiDate, AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    final yearOriginal = l10n.showOriginal != "false"
        ? '${YEAR_NAMES[badiDate.yearInVahid]} - '
        : '';
    final language = Localizations.localeOf(context).languageCode;
    final yearTranslation =
        YEAR_NAME_TRANSLATIONS[language]?[badiDate.yearInVahid] ?? '';
    final yearInVahid = '$yearOriginal$yearTranslation';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.vahidTitle,
          style: textTheme.titleMedium,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: MAX_WIDTH),
          child: Text(
            l10n.vahidExplanation,
            style: textTheme.bodySmall,
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: MAX_WIDTH),
          child: Text(
              l10n.vahid(badiDate.vahid, badiDate.yearInVahid, yearInVahid,
                  badiDate.year),
              style: textTheme.titleSmall),
        ),
      ],
    );
  }

  Widget _buildSunsetAndRiseInfo(
      BuildContext context, BadiDate badiDate, AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    final lng = config.longitude;
    final lat = config.latitude;
    final sunCalcTimes = lat != null && lng != null
        ? SunCalc.getTimes(dateTime.toUtc(),
            lat: lat, lng: lng, height: config.altitude ?? 0)
        : null;
    final sunset = sunCalcTimes?.sunset?.toLocal();
    final sunrise = sunCalcTimes?.sunrise?.toLocal();
    final noon = sunCalcTimes?.solarNoon?.toLocal();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (badiDate.isPeriodOfFast)
          Text(
            l10n.periodOfFast,
            style: textTheme.titleMedium,
          ),
        if (sunrise != null) Text(l10n.sunrise(Utils.fmtTime(sunrise))),
        if (noon != null) Text(l10n.noon(Utils.fmtTime(noon))),
        if (sunset != null) Text(l10n.sunset(Utils.fmtTime(sunset))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return Container();
    }
    final textTheme = Theme.of(context).textTheme;
    final BadiDate badiDate = BadiDate.fromDate(
      dateTime,
      longitude: config.longitude,
      latitude: config.latitude,
      altitude: config.altitude,
    );
    final content = [
      Text(
        Utils.fmtDateTime(
          dateTime,
          fmtIndex: config.dateFormatIndex,
          language: config.language,
        ),
        style: textTheme.titleMedium,
      ),
      Text(
        Utils.fmtBadiDate(badiDate,
            fmtIndex: config.dateFormatIndex, ayyamIHa: l10n.ayyamiha),
        style: textTheme.titleMedium,
      ),
      _buildHolydayInfo(context, badiDate, l10n),
      _sizedBox(),
      _buildSunsetAndRiseInfo(context, badiDate, l10n),
      _sizedBox(),
      _buildDayOfTheWeek(context, badiDate, l10n),
      _sizedBox(),
      _buildMonthAndDay(context, badiDate, l10n),
      _sizedBox(),
      _buildVahidAndYear(context, badiDate, l10n),
    ];
    if (asSliver) {
      final datePickerButton = datePicker;
      return SliverList.list(
        key: Key('full-date'),
        children: [
          _sizedBox(32),
          ...content,
          _sizedBox(32),
          if (datePickerButton != null)
            Container(
              padding: EdgeInsets.only(bottom: 32, left: 640),
              width: MAX_WIDTH,
              alignment: Alignment.centerLeft,
              child: datePickerButton,
            ),
        ],
      );
    }
    return ListView(
      key: Key('full-date'),
      children: content,
    );
  }

  Widget _sizedBox([double height = 16]) {
    return SizedBox(height: height);
  }
}
