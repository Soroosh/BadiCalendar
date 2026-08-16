// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get showOriginal => 'true';

  @override
  String get appName => 'Calendrier Badīʿ';

  @override
  String dayDifference(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dans $count jours',
      one: 'Demain',
      zero: 'Aujourd\'hui ',
    );
    return '$_temp0';
  }

  @override
  String get ayyamiha => 'Ayyám-i-Há';

  @override
  String begin(Object begin) {
    return 'De $begin';
  }

  @override
  String end(Object end) {
    return 'Jusque $end';
  }

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get hideSunsetInDates => 'Masquer les heures de coucher du soleil';

  @override
  String get dateFormat => 'Format de date';

  @override
  String dateFormatFromIndex(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count not set',
      two: 'mois/journée/an',
      one: 'journée.mois.an',
      zero: 'an-mois-journée',
    );
    return '$_temp0';
  }

  @override
  String get locationSettingsTitle => 'Méthode de localisation';

  @override
  String locationSettingsMethod(num index) {
    String _temp0 = intl.Intl.pluralLogic(
      index,
      locale: localeName,
      other: 'N\'utilisez pas la localisation',
      one: 'Emplacement défini manuellement',
      zero: 'Localisation automatique',
    );
    return '$_temp0';
  }

  @override
  String get longitude => 'Longitude';

  @override
  String get longitudeHelper => 'Valeurs négatives pour l\'Ouest.';

  @override
  String get latitude => 'Latitude';

  @override
  String get latitudeHelper => 'Valeurs négatives pour le Sud.';

  @override
  String get locationError =>
      'La valeur est erronée. S\'il vous plaît changer.';

  @override
  String get languageSettingsTitle => 'Langue';

  @override
  String get feasts => 'Fêtes';

  @override
  String get holyDayTab => 'Jours fériés';

  @override
  String get upcoming => 'Prochains jours saints et spéciaux';

  @override
  String get fullDate => 'Date Badí‘';

  @override
  String get ok => 'D\'ACCORD';

  @override
  String get cancel => 'ANNULER';

  @override
  String get selectADate => 'Sélectionnez une date';

  @override
  String get specialDay => 'Jour fériés et spécial:';

  @override
  String get periodOfFast => 'Période de jeûne';

  @override
  String sunset(Object time) {
    return 'Coucher de soleil à $time';
  }

  @override
  String sunrise(Object time) {
    return 'Lever du soleil à $time';
  }

  @override
  String noon(Object time) {
    return 'Midi $time';
  }

  @override
  String dayAndMonth(Object month, Object day) {
    return 'Le nom du jour est $day du mois $month';
  }

  @override
  String get dayAndMonthTitle => 'Nom du mois et du jour:';

  @override
  String get feastHint => 'Le premier jour des mois. C\'est un jour de fête.';

  @override
  String get dayAndMonthExplanation =>
      'Each of the 19 days of a month has a name. The names are the same as the month names- the first day of the month is the day Bahá and the last day of the month is the day ‘Alá’.';

  @override
  String dayOfTheWeek(Object day) {
    return 'Le jour de la semaine est $day.';
  }

  @override
  String get weekDayTitle => 'Jour de la semaine:';

  @override
  String get vahidTitle => 'An, Wāḥid et Kull-i Šay:';

  @override
  String get vahidExplanation =>
      'The Badí‘ Calendar defines Váḥid which is a period of 19 years. Each year in the Váḥid has a name. 19 Váḥids (361 years) are a Kull-i-Shay’.';

  @override
  String vahid(Object vahid, Object yearInVahid, Object yearName, Object year) {
    return 'The year $year in the Badi calendar is the year $yearInVahid in the Váḥid $vahid of the 1st Kull-i-Shay and has the name $yearName.';
  }

  @override
  String get skip => 'SAUTER';

  @override
  String get next => 'PROCHAIN';

  @override
  String get fin => 'FIN';

  @override
  String get selectLanguage =>
      'Sélectionnez une langue et le format de date préféré';

  @override
  String get selectLocationMethod => 'Sélectionnez la méthode de localisation';

  @override
  String get locationDescription =>
      'This app can use your location to calculate the sunset time. You can either let the app use your device location, set the location manually, or don\'t use locations. If you don\'t use location, 6pm will be used as sunset time. You can change settings anytime.';

  @override
  String get darkModeTitle => 'Dark Mode';

  @override
  String get faAvailable => 'Persian is available again:';

  @override
  String get darkModeDescription =>
      'Dark mode is now used if dark mode is set in your system settings.';

  @override
  String get hideSunsetTimesTitle => 'Début de journée';

  @override
  String get hideSunsetTimesDescription =>
      'Une journée du calendrier Badi commence au coucher du soleil. Si vous souhaitez omettre les heures de coucher du soleil pour un affichage simplifié, cochez la case suivante.';
}
