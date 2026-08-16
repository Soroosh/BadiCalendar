import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('tr')
  ];

  /// Should also the original text be shown.
  ///
  /// In en, this message translates to:
  /// **'true'**
  String get showOriginal;

  /// The name of the app
  ///
  /// In en, this message translates to:
  /// **'Bahá’í Calendar'**
  String get appName;

  /// The difference in days
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Today} =1{Tomorrow} other{In {count} days}}'**
  String dayDifference(num count);

  /// Ayyam-i-Ha
  ///
  /// In en, this message translates to:
  /// **'Ayyám-i-Há'**
  String get ayyamiha;

  /// Begin date
  ///
  /// In en, this message translates to:
  /// **'From {begin}'**
  String begin(Object begin);

  /// End date
  ///
  /// In en, this message translates to:
  /// **'Till {end}'**
  String end(Object end);

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Label for the hide sunset setting
  ///
  /// In en, this message translates to:
  /// **'Hide sunset times'**
  String get hideSunsetInDates;

  /// Label for date format selector
  ///
  /// In en, this message translates to:
  /// **'Date format'**
  String get dateFormat;

  /// Radio labels
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{year-month-day} =1{day.month.year} =2{month/day/year} other{{count} not set}}'**
  String dateFormatFromIndex(num count);

  /// Title for the location section in the settings
  ///
  /// In en, this message translates to:
  /// **'Location Method'**
  String get locationSettingsTitle;

  /// Radio title for location method
  ///
  /// In en, this message translates to:
  /// **'{index, plural, =0{Auto locate} =1{Manually set location} other{Do not use location}}'**
  String locationSettingsMethod(num index);

  /// longitude
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// hint text for the longitude input
  ///
  /// In en, this message translates to:
  /// **'Decimal value. Negative values for West.'**
  String get longitudeHelper;

  /// Latitude
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// hint text for the latitude input
  ///
  /// In en, this message translates to:
  /// **'Decimal value. Negative values for South.'**
  String get latitudeHelper;

  /// hint text for the false location input
  ///
  /// In en, this message translates to:
  /// **'Value is erroneous. Please change.'**
  String get locationError;

  /// Title for the language section in the settings
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSettingsTitle;

  /// Tab bar text for the Feasts tab
  ///
  /// In en, this message translates to:
  /// **'Feasts'**
  String get feasts;

  /// Tab bar text for the Holy Days tab
  ///
  /// In en, this message translates to:
  /// **'Holy Days'**
  String get holyDayTab;

  /// Text for the Holy Day tab
  ///
  /// In en, this message translates to:
  /// **'Upcoming Holy and special days'**
  String get upcoming;

  /// Tab bar text for the full date tab
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get fullDate;

  /// Confirm
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Disapprove
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel;

  /// Calendar picker helper text
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get selectADate;

  /// Holy day note in the full date tab
  ///
  /// In en, this message translates to:
  /// **'Holy and special day:'**
  String get specialDay;

  /// Fast note in the full date tab
  ///
  /// In en, this message translates to:
  /// **'Period of fast'**
  String get periodOfFast;

  /// Sunset note in the full date tab
  ///
  /// In en, this message translates to:
  /// **'Sunset at {time}'**
  String sunset(Object time);

  /// Sunrise note in the full date tab
  ///
  /// In en, this message translates to:
  /// **'Sunrise at {time}'**
  String sunrise(Object time);

  /// Noon note in the full date tab
  ///
  /// In en, this message translates to:
  /// **'Noon at {time}'**
  String noon(Object time);

  /// Day and month
  ///
  /// In en, this message translates to:
  /// **'The name of the day is {day} of the month {month}'**
  String dayAndMonth(Object month, Object day);

  /// Day and month title
  ///
  /// In en, this message translates to:
  /// **'Month and Day name:'**
  String get dayAndMonthTitle;

  /// Hint that it's a feast day
  ///
  /// In en, this message translates to:
  /// **'It\'s the first day of the month. This is a feast day.'**
  String get feastHint;

  /// Explanation on Day names
  ///
  /// In en, this message translates to:
  /// **'Each of the 19 days of a month has a name. The names are the same as the month names- the first day of the month is the day Bahá and the last day of the month is the day ‘Alá’.'**
  String get dayAndMonthExplanation;

  /// Day of the week
  ///
  /// In en, this message translates to:
  /// **'The day of the week is {day}.'**
  String dayOfTheWeek(Object day);

  /// Weekday title
  ///
  /// In en, this message translates to:
  /// **'Weekday:'**
  String get weekDayTitle;

  /// Vahid and Kull-i-Shay title
  ///
  /// In en, this message translates to:
  /// **'Year, Vahid, and Kull-i-Shay:'**
  String get vahidTitle;

  /// Explanation of Vahid and Kull-i-Shay, and year name
  ///
  /// In en, this message translates to:
  /// **'The Badí‘ Calendar defines Váḥid which is a period of 19 years. Each year in the Váḥid has a name. 19 Váḥids (361 years) are a Kull-i-Shay’.'**
  String get vahidExplanation;

  /// Vahid and Kull-i-Shay of the date
  ///
  /// In en, this message translates to:
  /// **'The year {year} in the Badi calendar is the year {yearInVahid} in the Váḥid {vahid} of the 1st Kull-i-Shay and has the name {yearName}.'**
  String vahid(Object vahid, Object yearInVahid, Object yearName, Object year);

  /// Skip button text
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// Next button text
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get next;

  /// Finish button text
  ///
  /// In en, this message translates to:
  /// **'FINISH'**
  String get fin;

  /// Title for the language and date format section dialog
  ///
  /// In en, this message translates to:
  /// **'Select a language and the preferred date format'**
  String get selectLanguage;

  /// Title for the location method section dialog
  ///
  /// In en, this message translates to:
  /// **'Select location method'**
  String get selectLocationMethod;

  /// Explanation on why to use location
  ///
  /// In en, this message translates to:
  /// **'This app can use your location to calculate the sunset time. You can either let the app use your device location, set the location manually, or don\'t use locations. If you don\'t use location, 6pm will be used as sunset time. You can change the settings anytime.'**
  String get locationDescription;

  /// Title for the dark mode dialog
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkModeTitle;

  /// Announcing that FA is back
  ///
  /// In en, this message translates to:
  /// **'Persian is available again:'**
  String get faAvailable;

  /// Introducing for the dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark mode is now used if it is set in your system settings.'**
  String get darkModeDescription;

  /// Title for the hide sunset times settings
  ///
  /// In en, this message translates to:
  /// **'Start of the day'**
  String get hideSunsetTimesTitle;

  /// Introducing for the hide sunset times settings
  ///
  /// In en, this message translates to:
  /// **'A day in the Badi calendar starts at sunset. If you like to omit sunset times for a simplified display, check the following checkbox.'**
  String get hideSunsetTimesDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fa',
        'fr',
        'tr'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
