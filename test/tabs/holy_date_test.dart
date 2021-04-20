import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/tabs/holy_day.dart';
import 'package:badi_calendar/widget/date_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWidget(HolyDay(config: Configuration())));

    // Verify tabs and settings.
    expect(find.byType(DateCard), findsWidgets);
    expect(find.text('Upcoming Holy and special days'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_upward), findsNothing);
    final gesture = await tester.startGesture(Offset(0, 300));
    await gesture.moveBy(Offset(0, -300));
    await tester.pump();
    expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.byIcon(Icons.arrow_upward), findsNothing);
  });
}
