import 'package:badi_calendar/model/configuration.dart';
import 'package:badi_calendar/widget/intro_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_helper.dart';
import 'intro_dialog_test.mocks.dart';

@GenerateMocks([ConfigurationProvider])
void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    final mockProvider = MockConfigurationProvider();
    when(mockProvider.listenToConfiguration)
        .thenReturn(ValueNotifier(Configuration()));
    when(mockProvider.configuration)
        .thenReturn(Configuration(seenDialogVersion: 0));
    when(mockProvider.saveSeenDialogVersion(any))
        .thenAnswer((realInvocation) => Future.value(null));
    await tester.pumpWidget(wrapWidget(IntroDialog(mockProvider, (_) {})),
        Duration(milliseconds: 10));

    expect(find.byType(SimpleDialog), findsOneWidget);
    // Verify tabs and settings.
    await tester.tap(find.byType(TextButton).last);
    verify(mockProvider.saveSeenDialogVersion(1)).called(1);
  });
  testWidgets('skip other pages', (WidgetTester tester) async {
    final mockProvider = MockConfigurationProvider();
    when(mockProvider.listenToConfiguration)
        .thenReturn(ValueNotifier(Configuration()));
    when(mockProvider.configuration)
        .thenReturn(Configuration(seenDialogVersion: 0));
    when(mockProvider.saveSeenDialogVersion(any))
        .thenAnswer((realInvocation) => Future.value(null));
    await tester.pumpWidget(wrapWidget(IntroDialog(mockProvider, (_) {})),
        Duration(milliseconds: 10));

    expect(find.byType(SimpleDialog), findsOneWidget);
    // Verify tabs and settings.
    await tester.tap(find.byType(TextButton).first);
    verify(mockProvider.saveSeenDialogVersion(3)).called(1);
  });
}
