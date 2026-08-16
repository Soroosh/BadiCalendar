// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get showOriginal => 'false';

  @override
  String get appName => 'تقویم بهایی';

  @override
  String dayDifference(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: ' در $count روز ',
      one: 'فردا',
      zero: 'امروز',
    );
    return '$_temp0';
  }

  @override
  String get ayyamiha => 'ايام الهاء';

  @override
  String begin(Object begin) {
    return 'از $begin';
  }

  @override
  String end(Object end) {
    return 'تا $end';
  }

  @override
  String get settingsTitle => 'تنظیم';

  @override
  String get hideSunsetInDates => 'زمانهای غروب آفتاب را مخفی کنید';

  @override
  String get dateFormat => 'قالب';

  @override
  String dateFormatFromIndex(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count not set',
      two: 'ماه/روز/سال',
      one: 'روز.ماه.سال',
      zero: 'سال-ماه-روز',
    );
    return '$_temp0';
  }

  @override
  String get locationSettingsTitle => 'موقعیت';

  @override
  String locationSettingsMethod(num index) {
    String _temp0 = intl.Intl.pluralLogic(
      index,
      locale: localeName,
      other: 'از مکان استفاده نکنید',
      one: 'مکان را به صورت دستی تنظیم کنید',
      zero: 'مکان یابی خودکار',
    );
    return '$_temp0';
  }

  @override
  String get longitude => 'عرض جغرافیایی';

  @override
  String get longitudeHelper => 'ارزشهای منفی برای غرب';

  @override
  String get latitude => 'عرض جغرافیایی';

  @override
  String get latitudeHelper => 'مقادیر منفی برای جنوب.';

  @override
  String get locationError => 'ارزش اشتباه است. لطفا عوض کنید';

  @override
  String get languageSettingsTitle => 'زبان';

  @override
  String get feasts => 'ضیافت';

  @override
  String get holyDayTab => 'ایام متبرکه';

  @override
  String get upcoming => 'روزهای مقدس و خاص آینده';

  @override
  String get fullDate => 'تاریخ';

  @override
  String get ok => 'خوب';

  @override
  String get cancel => 'لغو';

  @override
  String get selectADate => 'تاریخ را انتخاب کنید';

  @override
  String get specialDay => 'روز مقدس و ویژه:';

  @override
  String get periodOfFast => 'ایام روزه';

  @override
  String sunset(Object time) {
    return 'غروب $time';
  }

  @override
  String sunrise(Object time) {
    return 'طلوع آفتاب $time';
  }

  @override
  String noon(Object time) {
    return 'ظهر $time';
  }

  @override
  String dayAndMonth(Object month, Object day) {
    return 'نام روز $day ماه $month';
  }

  @override
  String get dayAndMonthTitle => 'نام ماه و روز:';

  @override
  String get feastHint => 'روز اول ماه است. این روز ضیافت است.';

  @override
  String get dayAndMonthExplanation =>
      'هر ۱۹ روز یک ماه یک نام دارد. نام ها همان نام ماه ها هستند - اولین روز ماه ، روز بها و آخرین روز ماه ، روز علاء است';

  @override
  String dayOfTheWeek(Object day) {
    return 'روز هفته $day.';
  }

  @override
  String get weekDayTitle => 'روز هفته';

  @override
  String get vahidTitle => 'سال, واحد, و كل شيء:';

  @override
  String get vahidExplanation =>
      'تقویم بهایی واحد را تعریف می کند که یک دوره ۱۹ ساله است. هر سال در واحد یک نام دارد. ۱۹ واحد (۳۶۱ سال) یک کل شی است.';

  @override
  String vahid(Object vahid, Object yearInVahid, Object yearName, Object year) {
    return 'سال $year در تقویم بهایی سال $yearInVahid در واحد $vahid اول کال شی است و نام آن سال $yearName است';
  }

  @override
  String get skip => 'پرش';

  @override
  String get next => 'بعد';

  @override
  String get fin => 'تمام';

  @override
  String get selectLanguage => 'یک زبان و قالب تاریخ را انتخاب کنید';

  @override
  String get selectLocationMethod => 'روش مکان را انتخاب کنید';

  @override
  String get locationDescription =>
      'این برنامه می تواند از مکان شما برای محاسبه زمان غروب آفتاب استفاده کند. می توانید به برنامه اجازه دهید از مکان دستگاه شما استفاده کند ، مکان را به صورت دستی تنظیم کند یا از مکان استفاده نکند. اگر از مکان استفاده نکنید ، ساعت 6 عصر به عنوان زمان غروب آفتاب استفاده می شود. در هر زمان می توانید تنظیمات را تغییر دهید';

  @override
  String get darkModeTitle => 'تم تاریک';

  @override
  String get faAvailable => '';

  @override
  String get darkModeDescription =>
      'اگر تم تاریک در تنظیمات سیستم شما تنظیم شود ، اکنون از تم تاریک استفاده می شود.';

  @override
  String get hideSunsetTimesTitle => 'شروع روز';

  @override
  String get hideSunsetTimesDescription =>
      'روز در تقویم بهایی از غروب خورشید آغاز می شود. اگر می خواهید زمان غروب آفتاب را برای نمایش ساده حذف کنید کادر تأیید زیر را علامت بزنید';
}
