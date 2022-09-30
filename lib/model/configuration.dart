import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocationMethod { AUTOMATIC, MANUEL, NONE }

const LASTEST_DIALOG_VERSION = 4;

class Configuration {
  final double? latitude;
  final double? longitude;
  final double? altitude;
  final LocationMethod locationMethod;
  final int dateFormatIndex;
  // String _dateFormat;
  final String? language;
  final int seenDialogVersion;
  final bool hideSunsetInDates;

  Configuration({
    this.latitude,
    this.longitude,
    this.locationMethod = LocationMethod.NONE,
    this.dateFormatIndex = 1,
    this.language,
    this.seenDialogVersion = LASTEST_DIALOG_VERSION + 1,
    this.altitude,
    this.hideSunsetInDates = false,
  });

  Configuration withUpdatedValue({
    double? newLatitude,
    double? newLongitude,
    double? newAltitude,
    LocationMethod? newLocationMethod,
    int? newDateFormatIndex,
    String? newLanguage,
    int? newSeenDialogVersion,
    bool? newHideSunsetInDates,
  }) {
    return Configuration(
        latitude: newLatitude ?? latitude,
        longitude: newLongitude ?? longitude,
        locationMethod: newLocationMethod ?? locationMethod,
        altitude: newAltitude ?? altitude,
        dateFormatIndex: newDateFormatIndex ?? dateFormatIndex,
        language: newLanguage ?? language,
        hideSunsetInDates: newHideSunsetInDates ?? hideSunsetInDates,
        seenDialogVersion: newSeenDialogVersion ?? seenDialogVersion);
  }

  Configuration resetLocation() {
    return Configuration(
      locationMethod: locationMethod,
      dateFormatIndex: dateFormatIndex,
      language: language,
      seenDialogVersion: seenDialogVersion,
      hideSunsetInDates: hideSunsetInDates,
    );
  }
}

class ConfigurationProvider {
  Configuration _configuration = Configuration();
  final _notifier = ValueNotifier(Configuration());

  Future<Configuration> readFromSharedPreferences() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    final latitude = prefs.getDouble('latitude');
    final longitude = prefs.getDouble('longitude');
    final altitude = prefs.getDouble('altitude');
    final dateFormatIndex = prefs.getInt('dateFormatIndex') ?? 0;
    // _dateFormat = _dateFormats[_dateFormatIndex];
    final language = prefs.getString('language');
    final locMethod = prefs.getString('locationMethod');
    LocationMethod locationMethod;
    switch (locMethod) {
      case 'AUTOMATIC':
        {
          locationMethod = LocationMethod.AUTOMATIC;
        }
        break;
      case 'MANUEL':
        {
          locationMethod = LocationMethod.MANUEL;
        }
        break;
      case 'NONE':
      default:
        {
          locationMethod = LocationMethod.NONE;
        }
        break;
    }

    final hideSunsetInDates = prefs.getBool('hideSunsetInDates') ?? false;
    final seenDialogVersion = prefs.getInt('seenDialogVersion') ?? 0;

    _configuration = Configuration(
        latitude: latitude,
        longitude: longitude,
        altitude: altitude,
        dateFormatIndex: dateFormatIndex,
        language: language,
        locationMethod: locationMethod,
        hideSunsetInDates: hideSunsetInDates,
        seenDialogVersion: seenDialogVersion);
    _notifier.value = _configuration;
    return _configuration;
  }

  Future<void> saveLatitude(double? value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    if (value == null) {
      prefs.remove('latitude');
    } else {
      prefs.setDouble('latitude', value);
    }
    _configuration = _configuration.withUpdatedValue(newLatitude: value);
    _notifier.value = _configuration;
  }

  Future<void> saveLongitude(double? value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    if (value == null) {
      prefs.remove('longitude');
    } else {
      prefs.setDouble('longitude', value);
    }
    _configuration = _configuration.withUpdatedValue(newLongitude: value);
    _notifier.value = _configuration;
  }

  Future<void> saveAltitude(double? value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    if (value == null) {
      prefs.remove('altitude');
    } else {
      prefs.setDouble('altitude', value);
    }
    _configuration = _configuration.withUpdatedValue(newAltitude: value);
    _notifier.value = _configuration;
  }

  Future<void> saveLanguage(String value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    prefs.setString('language', value);
    _configuration = _configuration.withUpdatedValue(newLanguage: value);
    _notifier.value = _configuration;
  }

  Future<void> saveDateFormat(int value) async {
    // _dateFormat = _dateFormats[value];
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    prefs.setInt('dateFormatIndex', value);
    _configuration = _configuration.withUpdatedValue(newDateFormatIndex: value);
    _notifier.value = _configuration;
  }

  Future<void> saveSeenDialogVersion(int version) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    prefs.setInt('seenDialogVersion', version);
    _configuration =
        _configuration.withUpdatedValue(newSeenDialogVersion: version);
    _notifier.value = _configuration;
  }

  Future<void> saveHideSunsetInDates(bool? value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    prefs.setBool('hideSunsetInDates', value ?? false);
    _configuration =
        _configuration.withUpdatedValue(newHideSunsetInDates: value);
    _notifier.value = _configuration;
  }

  Future<void> changeLocationMethod(LocationMethod value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    _configuration = _configuration.withUpdatedValue(newLocationMethod: value);
    final enumName =
        value.toString().substring(value.toString().indexOf('.') + 1);
    // set value
    prefs.setString('locationMethod', enumName);

    if (value == LocationMethod.AUTOMATIC) {
      setAutoLocation();
    } else if (value == LocationMethod.NONE) {
      prefs.remove('latitude');
      prefs.remove('longitude');
      prefs.remove('altitude');
      _configuration = _configuration.resetLocation();
    }
    _notifier.value = _configuration;
  }

  Future<void> setAutoLocation() async {
    if (_configuration.locationMethod != LocationMethod.AUTOMATIC) {
      return;
    }
    final Location location = Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }
    if (await location.hasPermission() == PermissionStatus.denied) {
      if (await location.requestPermission() != PermissionStatus.granted) {
        return;
      }
    }

    final position = await location.getLocation();
    saveLongitude(position.longitude);
    saveLatitude(position.latitude);
    saveAltitude(position.altitude);
  }

  Configuration get configuration => _configuration;

  ValueNotifier<Configuration> get listenToConfiguration => _notifier;
}
