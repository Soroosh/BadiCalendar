import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/tabs/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_helper.dart';
import 'settings_test.mocks.dart';

@GenerateMocks([ConfigurationProvider])
void main() {
  testWidgets('Shows Intro Dialog', (WidgetTester tester) async {
    final mockProvider = MockConfigurationProvider();
    when(mockProvider.readFromSharedPreferences())
        .thenAnswer((realInvocation) async => Future.value(Configuration()));
    when(mockProvider.configuration)
        .thenReturn(Configuration(seenDialogVersion: 0));
    when(mockProvider.listenToConfiguration)
        .thenReturn(ValueNotifier(Configuration()));
    await tester.pumpWidget(wrapWidget(Settings(mockProvider, (_) {})));

    // Verify tabs and settings.
    verify(mockProvider.readFromSharedPreferences()).called(1);
    expect(find.byType(SimpleDialog), findsOneWidget);
  });
}
