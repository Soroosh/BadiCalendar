import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/widget/date_format_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_helper.dart';
import 'date_format_setting_test.mocks.dart';

@GenerateMocks([ConfigurationProvider])
void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    final mockProvider = MockConfigurationProvider();
    when(mockProvider.listenToConfiguration)
        .thenReturn(ValueNotifier(Configuration()));
    when(mockProvider.saveDateFormat(any))
        .thenAnswer((realInvocation) => Future.value(null));
    await tester.pumpWidget(wrapWidget(DateFormatSetting(mockProvider)),
        Duration(milliseconds: 10));

    // Verify tabs and settings.
    verify(mockProvider.listenToConfiguration).called(1);
    await tester.tap(find.byType(ListTile).first);
    verify(mockProvider.saveDateFormat(0)).called(1);
  });
}
