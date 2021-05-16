import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/tabs/settings.dart';
import 'package:badi_calendar/widget/date_format_setting.dart';
import 'package:badi_calendar/widget/language_setting.dart';
import 'package:badi_calendar/widget/location_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_helper.dart';
import 'settings_test.mocks.dart';

@GenerateMocks([ConfigurationProvider])
void main() {
  testWidgets('renders', (WidgetTester tester) async {
    final mockProvider = MockConfigurationProvider();
    when(mockProvider.configuration)
        .thenReturn(Configuration(seenDialogVersion: 0));
    when(mockProvider.listenToConfiguration)
        .thenReturn(ValueNotifier(Configuration()));
    await tester.pumpWidget(wrapWidget(Settings(mockProvider, (_) {})));

    // Verify settings.
    expect(find.byType(LocationSetting), findsOneWidget);
    expect(find.byType(LanguageSetting), findsOneWidget);
    expect(find.byType(DateFormatSetting), findsOneWidget);
  });
}
