// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get showOriginal => 'true';

  @override
  String get appName => 'Bahá’í Calendar';

  @override
  String dayDifference(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count days',
      one: 'Tomorrow',
      zero: 'Today',
    );
    return '$_temp0';
  }

  @override
  String get ayyamiha => 'Ayyám-i-Há';

  @override
  String begin(Object begin) {
    return 'From $begin';
  }

  @override
  String end(Object end) {
    return 'Till $end';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get hideSunsetInDates => 'Hide sunset times';

  @override
  String get dateFormat => 'Date format';

  @override
  String dateFormatFromIndex(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count not set',
      two: 'month/day/year',
      one: 'day.month.year',
      zero: 'year-month-day',
    );
    return '$_temp0';
  }

  @override
  String get locationSettingsTitle => 'Location Method';

  @override
  String locationSettingsMethod(num index) {
    String _temp0 = intl.Intl.pluralLogic(
      index,
      locale: localeName,
      other: 'Do not use location',
      one: 'Manually set location',
      zero: 'Auto locate',
    );
    return '$_temp0';
  }

  @override
  String get longitude => 'Longitude';

  @override
  String get longitudeHelper => 'Decimal value. Negative values for West.';

  @override
  String get latitude => 'Latitude';

  @override
  String get latitudeHelper => 'Decimal value. Negative values for South.';

  @override
  String get locationError => 'Value is erroneous. Please change.';

  @override
  String get languageSettingsTitle => 'Language';

  @override
  String get feasts => 'Feasts';

  @override
  String get holyDayTab => 'Holy Days';

  @override
  String get upcoming => 'Upcoming Holy and special days';

  @override
  String get fullDate => 'Date';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'CANCEL';

  @override
  String get selectADate => 'Select a date';

  @override
  String get specialDay => 'Holy and special day:';

  @override
  String get periodOfFast => 'Period of fast';

  @override
  String sunset(Object time) {
    return 'Sunset at $time';
  }

  @override
  String sunrise(Object time) {
    return 'Sunrise at $time';
  }

  @override
  String noon(Object time) {
    return 'Noon at $time';
  }

  @override
  String dayAndMonth(Object month, Object day) {
    return 'The name of the day is $day of the month $month';
  }

  @override
  String get dayAndMonthTitle => 'Month and Day name:';

  @override
  String get feastHint =>
      'It\'s the first day of the month. This is a feast day.';

  @override
  String get dayAndMonthExplanation =>
      'Each of the 19 days of a month has a name. The names are the same as the month names- the first day of the month is the day Bahá and the last day of the month is the day ‘Alá’.';

  @override
  String dayOfTheWeek(Object day) {
    return 'The day of the week is $day.';
  }

  @override
  String get weekDayTitle => 'Weekday:';

  @override
  String get vahidTitle => 'Year, Vahid, and Kull-i-Shay:';

  @override
  String get vahidExplanation =>
      'The Badí‘ Calendar defines Váḥid which is a period of 19 years. Each year in the Váḥid has a name. 19 Váḥids (361 years) are a Kull-i-Shay’.';

  @override
  String vahid(Object vahid, Object yearInVahid, Object yearName, Object year) {
    return 'The year $year in the Badi calendar is the year $yearInVahid in the Váḥid $vahid of the 1st Kull-i-Shay and has the name $yearName.';
  }

  @override
  String get skip => 'SKIP';

  @override
  String get next => 'NEXT';

  @override
  String get fin => 'FINISH';

  @override
  String get selectLanguage =>
      'Select a language and the preferred date format';

  @override
  String get selectLocationMethod => 'Select location method';

  @override
  String get locationDescription =>
      'This app can use your location to calculate the sunset time. You can either let the app use your device location, set the location manually, or don\'t use locations. If you don\'t use location, 6pm will be used as sunset time. You can change the settings anytime.';

  @override
  String get darkModeTitle => 'Dark Mode';

  @override
  String get faAvailable => 'Persian is available again:';

  @override
  String get darkModeDescription =>
      'Dark mode is now used if it is set in your system settings.';

  @override
  String get hideSunsetTimesTitle => 'Start of the day';

  @override
  String get hideSunsetTimesDescription =>
      'A day in the Badi calendar starts at sunset. If you like to omit sunset times for a simplified display, check the following checkbox.';
}
