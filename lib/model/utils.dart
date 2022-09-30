import 'package:badi_calendar/model/names.dart';
import 'package:badi_date/badi_date.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class Utils {
  static final twoDigitFormatter = NumberFormat('00');

  static String fmtBadiDate(BadiDate badiDate,
      {int? fmtIndex = 0, String ayyamIHa = ''}) {
    final year = badiDate.year;
    final month = twoDigitFormatter.format(badiDate.month);
    final day = twoDigitFormatter.format(badiDate.day);
    switch (fmtIndex) {
      case 1:
        final separator = '.';
        if (badiDate.isAyyamIHa) {
          return '$day$separator$ayyamIHa$separator$year';
        }
        return '$day$separator$month$separator$year';
      case 2:
        final separator = '/';
        if (badiDate.isAyyamIHa) {
          return '$ayyamIHa$separator$day$separator$year';
        }
        return '$month$separator$day$separator$year';
      case 0:
      default:
        final separator = '-';
        if (badiDate.isAyyamIHa) {
          return '$year$separator$ayyamIHa$separator$day';
        }
        return '$year$separator$month$separator$day';
    }
  }

  static String fmtDateTime(
    DateTime date, {
    int? fmtIndex = 0,
    String? language,
  }) {
    final dateString = fmtDate(date, fmtIndex: fmtIndex, language: language);
    final time = fmtTime(date);

    return '$dateString $time';
  }

  static String fmtDate(
    DateTime date, {
    int? fmtIndex = 0,
    String? language,
  }) {
    final year = date.year;
    final month = twoDigitFormatter.format(date.month);
    final day = twoDigitFormatter.format(date.day);
    final lang = language?.isEmpty ?? true ? 'en' : language;
    final weekday = WEEKDAYS_GREGORIAN[lang]?[date.weekday] ?? '';

    switch (fmtIndex) {
      case 1:
        final separator = '.';
        return '$weekday, $day$separator$month$separator$year';
      case 2:
        final separator = '/';
        return '$weekday, $month$separator$day$separator$year';
      case 0:
      default:
        final separator = '-';
        return '$weekday, $year$separator$month$separator$day';
    }
  }

  static String fmtTime(DateTime date) {
    return '${twoDigitFormatter.format(date.hour)}:${twoDigitFormatter.format(date.minute)}';
  }

  /// returns the difference of the start date time of the BadiDate to now
  static Duration getDifferenceToNow(BadiDate badiDate) =>
      badiDate.startDateTime.difference(DateTime.now());

  /// returns a text with remaining days from now to badiDate
  static String? getRemainingDaysString(
    BadiDate badiDate,
    AppLocalizations l10n,
  ) {
    final difference = getDifferenceToNow(badiDate);
    if (difference > Duration(days: 18)) {
      return null;
    }
    if (difference.isNegative) {
      return l10n.dayDifference(0);
    }
    return l10n.dayDifference(difference.inDays + 1);
  }
}
