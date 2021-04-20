import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:badi_calendar/main.dart';

void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verify tabs and settings.
    expect(find.byType(TabBarView), findsOneWidget);
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('Feasts'), findsOneWidget);
    expect(find.text('Holy Days'), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });
}
