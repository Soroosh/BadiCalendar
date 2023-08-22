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
    expect(find.text('Year, Vahid, and Kull-i-Shay:'), findsOneWidget);
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(Duration(milliseconds: 10));
    expect(find.text('Select a date'), findsOneWidget);
  });

  testWidgets('displays correct weekday', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWidget(FullDate(config: Configuration())));

    await tester.tap(find.byIcon(Icons.calendar_today));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();
    await tester.enterText(find.byType(TextField), '05/26/2021');
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(
        find.text('The day of the week is ‘Idál - Justice.'), findsOneWidget);
  });
}
