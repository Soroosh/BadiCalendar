import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/widget/location_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_helper.dart';
import 'location_setting_test.mocks.dart';

@GenerateMocks([ConfigurationProvider])
void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    final mockProvider = MockConfigurationProvider();
    when(mockProvider.listenToConfiguration)
        .thenReturn(ValueNotifier(Configuration()));
    when(mockProvider.configuration)
        .thenReturn(Configuration(locationMethod: LocationMethod.AUTOMATIC));
    when(mockProvider.changeLocationMethod(any))
        .thenAnswer((realInvocation) => Future.value(null));
    when(mockProvider.saveLatitude(any))
        .thenAnswer((realInvocation) => Future.value(null));
    when(mockProvider.saveLanguage(any))
        .thenAnswer((saveLongitude) => Future.value(null));
    await tester.pumpWidget(
        wrapWidget(LocationSetting(mockProvider)), Duration(milliseconds: 10));

    expect(find.byType(TextField), findsNothing);
    // Verify tabs and settings.
    verify(mockProvider.listenToConfiguration).called(1);
    await tester.tap(find.byType(ListTile).first);
    verify(mockProvider.changeLocationMethod(any)).called(1);
  });
}
