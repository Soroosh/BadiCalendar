import 'package:badi_calendar/model/configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Configuration', () {
    test('resetLocation', () {
      final configuration = Configuration(
        latitude: 1.0,
        longitude: 1.0,
        altitude: 1.0,
        locationMethod: LocationMethod.AUTOMATIC,
        dateFormatIndex: 1,
        language: 'DE',
        seenDialogVersion: 2,
        hideSunsetInDates: true,
      );

      final result = configuration.resetLocation();

      expect(result.locationMethod, equals(LocationMethod.AUTOMATIC));
      expect(result.dateFormatIndex, 1);
      expect(result.language, 'DE');
      expect(result.seenDialogVersion, 2);
      expect(result.hideSunsetInDates, isTrue);
      expect(result.altitude, isNull);
      expect(result.longitude, isNull);
      expect(result.latitude, isNull);
    });
  });
}
