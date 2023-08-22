import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/model/names.dart';
import 'package:badi_calendar/model/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dart_suncalc/suncalc.dart';

import 'package:badi_date/badi_date.dart';

class FullDate extends StatefulWidget {
  final Configuration config;

  const FullDate({Key? key, required this.config}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FullDateState();
  }
}

class FullDateState extends State<FullDate> {
  DateTime _dateTime = DateTime.now();

  Widget _buildCalendarPicker(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FloatingActionButton(
      onPressed: () async {
        final newDate = await showDatePicker(
          context: context,
          initialDate: _dateTime,
          firstDate: DateTime(1844, 5, 23),
          lastDate: DateTime(1844 + BadiDate.LAST_YEAR_SUPPORTED, 3, 19),
          confirmText: l10n?.ok,
          cancelText: l10n?.cancel,
          helpText: l10n?.selectADate,
          locale: Localizations.localeOf(context),
        );
        if (newDate != null && newDate != _dateTime) {
          setState(() {
            _dateTime = DateTime(newDate.year, newDate.month, newDate.day,
                _dateTime.hour, _dateTime.minute);
          });
        }
      },
      child: Icon(Icons.calendar_today),
    );
  }

  Widget _buildHolydayInfo(BadiDate badiDate, AppLocalizations l10n) {
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
          style: textTheme.subtitle1,
        ),
        Text(
          holyDay,
          style: textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget _buildDayOfTheWeek(BadiDate badiDate, AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    final dayIndex = _dateTime.weekday;
    final dayOriginal =
        l10n.showOriginal != "false" ? '${WEEK_DAY[dayIndex]} - ' : '';
    final language = Localizations.localeOf(context).languageCode;
    final dayTranslation = WEEK_DAY_TRANSLATION[language]?[dayIndex] ?? '';
    final day = '$dayOriginal$dayTranslation';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        l10n.weekDayTitle,
        style: textTheme.subtitle1,
      ),
      Text(
        l10n.dayOfTheWeek(day),
        style: textTheme.bodyText1,
      ),
    ]);
  }

  Widget _buildMonthAndDay(BadiDate badiDate, AppLocalizations l10n) {
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
          style: textTheme.subtitle1,
        ),
        if (badiDate.day == 1) Text(l10n.feastHint),
        Text(l10n.dayAndMonthExplanation, style: textTheme.caption),
        Text(
          l10n.dayAndMonth(month, day),
          style: textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget _buildVahidAndYear(BadiDate badiDate, AppLocalizations l10n) {
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
          style: textTheme.subtitle1,
        ),
        Text(
          l10n.vahidExplanation,
          style: textTheme.caption,
        ),
        Text(
            l10n.vahid(badiDate.vahid, badiDate.yearInVahid, yearInVahid,
                badiDate.year),
            style: textTheme.subtitle2)
      ],
    );
  }

  Widget _buildSunsetAndRiseInfo(BadiDate badiDate, AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    final lng = widget.config.longitude;
    final lat = widget.config.latitude;
    final sunCalcTimes = lat != null && lng != null
        ? SunCalc.getTimes(_dateTime.toUtc(),
            lat: lat, lng: lng, height: widget.config.altitude ?? 0)
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
            style: textTheme.subtitle1,
          ),
        if (sunrise != null) Text(l10n.sunrise(Utils.fmtTime(sunrise))),
        if (noon != null) Text(l10n.noon(Utils.fmtTime(noon))),
        if (sunset != null) Text(l10n.sunset(Utils.fmtTime(sunset))),
      ],
    );
  }

  Widget _buildDateInfo() {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return Container();
    }
    final textTheme = Theme.of(context).textTheme;
    final BadiDate badiDate = BadiDate.fromDate(
      _dateTime,
      longitude: widget.config.longitude,
      latitude: widget.config.latitude,
      altitude: widget.config.altitude,
    );
    return ListView(
      children: <Widget>[
        Text(
          Utils.fmtDateTime(
            _dateTime,
            fmtIndex: widget.config.dateFormatIndex,
            language: widget.config.language,
          ),
          style: textTheme.subtitle1,
        ),
        Text(
          Utils.fmtBadiDate(badiDate,
              fmtIndex: widget.config.dateFormatIndex, ayyamIHa: l10n.ayyamiha),
          style: textTheme.subtitle1,
        ),
        _buildHolydayInfo(badiDate, l10n),
        _sizedBox(),
        _buildSunsetAndRiseInfo(badiDate, l10n),
        _sizedBox(),
        _buildDayOfTheWeek(badiDate, l10n),
        _sizedBox(),
        _buildMonthAndDay(badiDate, l10n),
        _sizedBox(),
        _buildVahidAndYear(badiDate, l10n),
      ],
    );
  }

  Widget _sizedBox([double height = 16]) {
    return SizedBox(height: height);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.all(20),
        child: SelectionArea(
            child: _buildDateInfo(),
            selectionControls: MaterialTextSelectionControls()),
      ),
      Positioned(
        bottom: 25,
        right: 25,
        child: _buildCalendarPicker(context),
      ),
    ]);
  }
}
