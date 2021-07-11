import 'package:badi_calendar/widget/intro_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    final mockProvider = FakeConfigurationProvider();
    await tester.pumpWidget(wrapWidget(IntroDialog(mockProvider, (_) {})));

    expect(find.byType(SimpleDialog), findsOneWidget);
    await tester.tap(find.byType(TextButton).last);
    expect(mockProvider.invocations.length, 1);
    expect(mockProvider.invocations.first, 'saveSeenDialogVersion');
    expect(mockProvider.arguments.first, 1);
  });

  testWidgets('skip other pages', (WidgetTester tester) async {
    final mockProvider = FakeConfigurationProvider();
    await tester.pumpWidget(wrapWidget(IntroDialog(mockProvider, (_) {})));

    expect(find.byType(SimpleDialog), findsOneWidget);
    await tester.tap(find.byType(TextButton).first);
    expect(mockProvider.invocations.length, 1);
    expect(mockProvider.invocations.first, 'saveSeenDialogVersion');
    expect(mockProvider.arguments.first, 4);
  });
}
