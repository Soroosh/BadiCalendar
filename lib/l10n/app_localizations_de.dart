// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get showOriginal => 'true';

  @override
  String get appName => 'Bahá’í Kalender';

  @override
  String dayDifference(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count Tagen',
      one: 'Morgen',
      zero: 'Heute',
    );
    return '$_temp0';
  }

  @override
  String get ayyamiha => 'Ayyám-i-Há';

  @override
  String begin(Object begin) {
    return 'Vom $begin';
  }

  @override
  String end(Object end) {
    return 'Bis $end';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get hideSunsetInDates => 'Sonnenuntergangszeiten nicht anzeigen';

  @override
  String get dateFormat => 'Datumsformat';

  @override
  String dateFormatFromIndex(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count not set',
      two: 'Monat/Tag/Jahr',
      one: 'Tag.Monat.Jahr',
      zero: 'Jahr-Monat-Tag',
    );
    return '$_temp0';
  }

  @override
  String get locationSettingsTitle => 'Positionierungsmethode';

  @override
  String locationSettingsMethod(num index) {
    String _temp0 = intl.Intl.pluralLogic(
      index,
      locale: localeName,
      other: 'Position nicht verwenden',
      one: 'Manuell setzten',
      zero: 'Geräteposition',
    );
    return '$_temp0';
  }

  @override
  String get longitude => 'Längengrad';

  @override
  String get longitudeHelper => 'Dezimalzahl - Negativer Wert für West.';

  @override
  String get latitude => 'Breitengrad';

  @override
  String get latitudeHelper => 'Dezimalzahl - Negativer Wert für Süd.';

  @override
  String get locationError => 'Eintrag ist fehlerhaft. Bitte ändern.';

  @override
  String get languageSettingsTitle => 'Sprache';

  @override
  String get feasts => '19-Tage-Feste';

  @override
  String get holyDayTab => 'Feiertage';

  @override
  String get upcoming => 'Die nächsten Feiertage und besondere Tage';

  @override
  String get fullDate => 'Datum';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'ABBRECHEN';

  @override
  String get selectADate => 'Datum auswählen';

  @override
  String get specialDay => 'Feiertage und besondere Tage:';

  @override
  String get periodOfFast => 'Fastenzeit';

  @override
  String sunset(Object time) {
    return 'Sonnenuntergang um $time';
  }

  @override
  String sunrise(Object time) {
    return 'Sonnenaufgang um $time';
  }

  @override
  String noon(Object time) {
    return 'Mittag um $time';
  }

  @override
  String dayAndMonth(Object month, Object day) {
    return 'Der Name des Tages ist $day im Monat $month';
  }

  @override
  String get dayAndMonthTitle => 'Monats- und Tagesname:';

  @override
  String get feastHint =>
      'Es ist der erste Tag des Monats. Es ist ein 19-Tagefest Tag.';

  @override
  String get dayAndMonthExplanation =>
      'Jedes der 19 Tage eines Monats hat einen Namen. Die Namen sind dieselben wie die Monatsnamen - der erste Tag des Monats ist der Tag Bahá und der letzte Tag des Monats ist der Tag ‘Alá’.';

  @override
  String dayOfTheWeek(Object day) {
    return 'Der Wochentag ist $day.';
  }

  @override
  String get weekDayTitle => 'Wochentag:';

  @override
  String get vahidTitle => 'Jahr, Vahid, und Kull-i-Shay:';

  @override
  String get vahidExplanation =>
      'Der Badí‘ Kalender hat die Zeiteinheit Váḥid, welches eine Periode von 19 Jahren ist. Jedes Jahr in einem Váḥid hat einen Namen. 19 Váḥids (361 Jahre) sind ein Kull-i-Shay’.';

  @override
  String vahid(Object vahid, Object yearInVahid, Object yearName, Object year) {
    return 'Das Jahr $year im Badi Kalender ist das Jahr $yearInVahid im Váḥid $vahid des ersten Kull-i-Shay und hat den Namen $yearName.';
  }

  @override
  String get skip => 'ABBRECHEN';

  @override
  String get next => 'WEITER';

  @override
  String get fin => 'FERTIG';

  @override
  String get selectLanguage =>
      'Stellen Sie die Sprache und gewünschte Datumsformat ein';

  @override
  String get selectLocationMethod =>
      'Stellen sie die gewünschte Positionierungsmethode ein';

  @override
  String get locationDescription =>
      'Dieses App kann Ihr Standort verwenden um die Zeit des Sonnenuntergangs zu berechnen. Sie können entweder den Standort des Gerätes benutzten, Ihren Standort manuell einstellen, oder keinen Standort verwenden. Wenn sie keinen Standort verwenden, wird der Sonnenuntergang auf 18 Uhr geschätzt. Sie können die Einstellungen jederzeit ändern.';

  @override
  String get darkModeTitle => 'Dunklemodus';

  @override
  String get faAvailable => 'Persisch ist wieder verfügbar:';

  @override
  String get darkModeDescription =>
      'Dunklemodus wird verwendet, wenn es in den Systemeinstellungen eingestellt ist.';

  @override
  String get hideSunsetTimesTitle => 'Start des Tages';

  @override
  String get hideSunsetTimesDescription =>
      'Der Tag startet im Badí-Kalender mit dem Sonnenuntergang. Wenn die Sonnenuntergangszeiten für eine vereinfachte Anzeige entfernt werden sollen, aktivieren Sie die folgende Checkbox.';
}
