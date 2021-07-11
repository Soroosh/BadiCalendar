import 'package:badi_date/badi_date.dart';
import 'package:flutter/material.dart';
import 'package:badi_calendar/model/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class _GeneralDateCard extends StatelessWidget {
  final List<Widget> children;

  const _GeneralDateCard(this.children, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Container(
        width: 256,
        padding: EdgeInsets.all(8),
        child: Column(children: children),
      ),
    );
  }
}

/// A card that shows the Badi date and the Georgian date.
/// ayyamIHaStart needs only to be set for the Ayyam-I-Ha card.
class DateCard extends StatelessWidget {
  final String title;
  final BadiDate date;
  final bool hideSunsetTimes;
  final int dateFormatIndex;
  final BadiDate? ayyamIHaStart;

  const DateCard({
    required this.title,
    required this.date,
    required this.dateFormatIndex,
    this.hideSunsetTimes = false,
    this.ayyamIHaStart,
    Key? key,
  }) : super(key: key);

  Widget _buildStartDate(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (ayyamIHaStart != null) {
      return hideSunsetTimes
          ? Text(l10n.begin(Utils.fmtDate(ayyamIHaStart!.endDateTime,
              fmtIndex: dateFormatIndex)))
          : Text(l10n.begin(Utils.fmtDateTime(ayyamIHaStart!.startDateTime,
              fmtIndex: dateFormatIndex)));
    }
    return hideSunsetTimes
        ? Container()
        : Text(l10n.begin(
            Utils.fmtDateTime(date.startDateTime, fmtIndex: dateFormatIndex)));
  }

  Widget _buildEndDate(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (!hideSunsetTimes) {
      return Text(l10n
          .end(Utils.fmtDateTime(date.endDateTime, fmtIndex: dateFormatIndex)));
    }
    return ayyamIHaStart == null
        ? Text(Utils.fmtDate(date.endDateTime, fmtIndex: dateFormatIndex))
        : Text(l10n
            .end(Utils.fmtDate(date.endDateTime, fmtIndex: dateFormatIndex)));
  }

  @override
  Widget build(BuildContext context) {
    final difference = Utils.getDifference(ayyamIHaStart ?? date);
    final l10n = AppLocalizations.of(context)!;

    return _GeneralDateCard(
      [
        Text(title, style: Theme.of(context).textTheme.subtitle1),
        if (ayyamIHaStart == null)
          Text(Utils.fmtBadiDate(date, fmtIndex: dateFormatIndex)),
        _buildStartDate(context),
        _buildEndDate(context),
        if (difference < 19) Text(l10n.dayDifference(difference))
      ],
    );
  }
}
