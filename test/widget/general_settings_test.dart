import 'package:badi_calendar/widget/general_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    final mockProvider = FakeConfigurationProvider();
    await tester.pumpWidget(
      wrapWidget(HideSunsetTimesSetting(mockProvider)),
    );

    expect(find.byType(TextField), findsNothing);
    expect(mockProvider.listenerCount, 1);
    await tester.tap(find.byType(ListTile));
    expect(mockProvider.invocations.length, 1);
    expect(mockProvider.invocations.first, 'saveHideSunsetInDates');
    expect(mockProvider.arguments.first, isTrue);
  });
}
