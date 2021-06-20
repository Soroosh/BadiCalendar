import 'package:badi_date/badi_date.dart';
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

  static String fmtDateTime(DateTime date, {int? fmtIndex = 0}) {
    final year = date.year;
    final month = twoDigitFormatter.format(date.month);
    final day = twoDigitFormatter.format(date.day);
    final time = fmtTime(date);

    switch (fmtIndex) {
      case 1:
        final separator = '.';
        return '$day$separator$month$separator$year $time';
      case 2:
        final separator = '/';
        return '$month$separator$day$separator$year $time';
      case 0:
      default:
        final separator = '-';
        return '$year$separator$month$separator$day $time';
    }
  }

  static String fmtTime(DateTime date) {
    return '${twoDigitFormatter.format(date.hour)}:${twoDigitFormatter.format(date.minute)}';
  }

  /// returns the difference of the start date time of the BadiDate to now
  /// difference is in days
  /// if difference is <0 0 is returned
  static int getDifference(BadiDate badiDate) {
    final difference = badiDate.startDateTime.difference(DateTime.now()).inDays;
    if (difference < 0) return 0;
    // diff in days just returns full day differences; therefore, we add 1
    return difference + 1;
  }
}
