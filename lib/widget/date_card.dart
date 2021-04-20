import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final List<Widget> children;

  const DateCard({required this.children, Key? key}) : super(key: key);

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
