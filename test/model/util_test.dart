import 'package:badi_calendar/model/utils.dart';
import 'package:badi_date/badi_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fmtBadiDate', () {
    final date1 = BadiDate(day: 1, year: 178, month: 2);
    final date2 = BadiDate(day: 1, year: 178, ayyamIHa: true);

    expect(Utils.fmtBadiDate(date1), equals('178-02-01'));
    expect(Utils.fmtBadiDate(date2, ayyamIHa: 'Ha'), equals('178-Ha-01'));

    expect(Utils.fmtBadiDate(date1, fmtIndex: 1), equals('01.02.178'));
    expect(Utils.fmtBadiDate(date2, fmtIndex: 1, ayyamIHa: 'Ha'),
        equals('01.Ha.178'));

    expect(Utils.fmtBadiDate(date1, fmtIndex: 2), equals('02/01/178'));
    expect(Utils.fmtBadiDate(date2, fmtIndex: 2, ayyamIHa: 'Ha'),
        equals('Ha/01/178'));
  });

  test('fmtDateTime', () {
    final date = DateTime(2021, 1, 2, 3, 4, 5);

    expect(Utils.fmtDateTime(date), equals('2021-01-02 03:04'));

    expect(Utils.fmtDateTime(date, fmtIndex: 1), equals('02.01.2021 03:04'));

    expect(Utils.fmtDateTime(date, fmtIndex: 2), equals('01/02/2021 03:04'));
  });

  test('fmtTime', () {
    final date = DateTime(2021, 1, 2, 3, 4, 5);

    expect(Utils.fmtTime(date), equals('03:04'));
  });
}
