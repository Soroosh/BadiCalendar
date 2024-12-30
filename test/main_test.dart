import 'package:badi_calendar/tabs/feasts.dart';
import 'package:badi_calendar/tabs/full_date.dart';
import 'package:badi_calendar/tabs/holy_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:badi_calendar/main.dart';

void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(400, 300);
    await tester.pumpWidget(MyApp());

    // Verify tabs and settings.
    expect(find.byType(TabBarView), findsOneWidget);
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('Feasts'), findsOneWidget);
    expect(find.text('Holy Days'), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });

  testWidgets('Renders for big screens', (WidgetTester tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1200, 900);
    await tester.pumpWidget(MyApp());

    // Verify tabs and settings.
    expect(find.byType(TabBarView), findsNothing);
    expect(find.text('Date'), findsNothing);
    expect(find.text('Feasts'), findsNothing);
    expect(find.text('Holy Days'), findsNothing);
    expect(find.byType(FullDate), findsOneWidget);
    expect(find.byType(FeastsList), findsOneWidget);
    expect(find.byType(HolyDayList), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });
}
