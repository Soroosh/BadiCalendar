import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/tabs/full_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWidget(FullDate(config: Configuration())));

    // Verify tabs and settings.
    expect(find.text('Weekday:'), findsOneWidget);
    expect(find.text('Month and Day name:'), findsOneWidget);
    expect(find.text('Year, Vahid, and Kull-i_Shay:'), findsOneWidget);
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Select a date'), findsOneWidget);
  });
}
