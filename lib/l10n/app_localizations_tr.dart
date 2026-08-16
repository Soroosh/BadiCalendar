// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get showOriginal => 'true';

  @override
  String get appName => 'Bahai Takvimi';

  @override
  String dayDifference(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün sonra',
      one: 'Yarın',
      zero: 'Bugün',
    );
    return '$_temp0';
  }

  @override
  String get ayyamiha => 'Ha Günleri';

  @override
  String begin(Object begin) {
    return 'Nereden $begin';
  }

  @override
  String end(Object end) {
    return 'Kadar $end';
  }

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get hideSunsetInDates => 'Gün batımı saatlerini gizle';

  @override
  String get dateFormat => 'Biçim';

  @override
  String dateFormatFromIndex(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count not set',
      two: 'ay/gün/yıl',
      one: 'gün.ay.yıl',
      zero: 'yıl-ay-gün',
    );
    return '$_temp0';
  }

  @override
  String get locationSettingsTitle => 'Konum Yöntemi';

  @override
  String locationSettingsMethod(num index) {
    String _temp0 = intl.Intl.pluralLogic(
      index,
      locale: localeName,
      other: 'Konumu kullanma',
      one: 'Manuel olarak konum ayarla',
      zero: 'Otomatik bul',
    );
    return '$_temp0';
  }

  @override
  String get longitude => 'Boylam';

  @override
  String get longitudeHelper => 'Batı için negatif değerler.';

  @override
  String get latitude => 'Enlem';

  @override
  String get latitudeHelper => 'Güney için negatif değerler.';

  @override
  String get locationError => 'Değer hatalı. Lütfen değiştir.';

  @override
  String get languageSettingsTitle => 'Dil';

  @override
  String get feasts => 'Ziyafetler';

  @override
  String get holyDayTab => 'Kutsal Günler';

  @override
  String get upcoming => 'Yaklaşan kutsal ve özel günler';

  @override
  String get fullDate => 'Tam Tarih';

  @override
  String get ok => 'iyi';

  @override
  String get cancel => 'iptal';

  @override
  String get selectADate => 'Bir tarih seçin';

  @override
  String get specialDay => 'Kutsal ve özel gün:';

  @override
  String get periodOfFast => 'Oruç dönemi';

  @override
  String sunset(Object time) {
    return 'Gün batımı $time';
  }

  @override
  String sunrise(Object time) {
    return 'Gün doğumu $time';
  }

  @override
  String noon(Object time) {
    return 'Öğle vakti $time';
  }

  @override
  String dayAndMonth(Object month, Object day) {
    return 'Günün adı $day ayın $month';
  }

  @override
  String get dayAndMonthTitle => 'Ay ve Gün adı:';

  @override
  String get feastHint => 'Ayın ilk günü. Bu bir bayram günü.';

  @override
  String get dayAndMonthExplanation =>
      'Each of the 19 days of a month has a name. The names are the same as the month names- the first day of the month is the day Bahá and the last day of the month is the day ‘Alá’.';

  @override
  String dayOfTheWeek(Object day) {
    return 'Haftanın günü $day.';
  }

  @override
  String get weekDayTitle => 'Hafta içi:';

  @override
  String get vahidTitle => 'Yıl, Vahid, ve Külli-Şey:';

  @override
  String get vahidExplanation =>
      'The Badí‘ Calendar defines Váḥid which is a period of 19 years. Each year in the Váḥid has a name. 19 Váḥids (361 years) are a Kull-i-Shay’.';

  @override
  String vahid(Object vahid, Object yearInVahid, Object yearName, Object year) {
    return 'The year $year in the Badi calendar is the year $yearInVahid in the Váḥid $vahid of the 1st Kull-i-Shay and has the name $yearName.';
  }

  @override
  String get skip => 'ATLA';

  @override
  String get next => 'SONRAKİ';

  @override
  String get fin => 'BİTİŞ';

  @override
  String get selectLanguage => 'Bir dil ve tercih edilen tarih formatını seçin';

  @override
  String get selectLocationMethod => 'Konum yöntemini seçin';

  @override
  String get locationDescription =>
      'This app can use your location to calculate the sunset time. You can either let the app use your device location, set the location manually, or don\'t use locations. If you don\'t use location, 6pm will be used as sunset time. You can change settings anytime.';

  @override
  String get darkModeTitle => 'Dark Mode';

  @override
  String get faAvailable => 'Persian is available again:';

  @override
  String get darkModeDescription =>
      'Dark mode is now used if it is set in your system settings.';

  @override
  String get hideSunsetTimesTitle => 'günün başlangıcı';

  @override
  String get hideSunsetTimesDescription =>
      'A day in the Badi calendar starts at sunset. If you like to omit sunset times for a simplified display, check the following checkbox.';
}
