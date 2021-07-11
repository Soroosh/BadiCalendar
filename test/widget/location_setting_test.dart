import 'package:badi_calendar/widget/location_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    final mockProvider = FakeConfigurationProvider();
    await tester.pumpWidget(
      wrapWidget(LocationSetting(mockProvider)),
    );

    expect(find.byType(TextField), findsNothing);
    expect(mockProvider.listenerCount, 1);
    await tester.tap(find.byType(ListTile).first);
    expect(mockProvider.invocations.length, 1);
    expect(mockProvider.invocations.first, 'changeLocationMethod');
  });
}
