import 'package:badi_calendar/tabs/settings.dart';
import 'package:badi_calendar/widget/date_format_setting.dart';
import 'package:badi_calendar/widget/general_settings.dart';
import 'package:badi_calendar/widget/language_setting.dart';
import 'package:badi_calendar/widget/location_setting.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper.dart';

void main() {
  testWidgets('renders', (WidgetTester tester) async {
    final mockProvider = FakeConfigurationProvider();
    await tester.pumpWidget(wrapWidget(Settings(mockProvider, (_) {})));

    // Verify settings.
    expect(find.byType(LocationSetting), findsOneWidget);
    expect(find.byType(LanguageSetting), findsOneWidget);
    expect(find.byType(DateFormatSetting), findsOneWidget);
    expect(find.byType(HideSunsetTimesSetting), findsOneWidget);
  });
}
