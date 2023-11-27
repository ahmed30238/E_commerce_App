import 'package:flutter/material.dart';

extension ListOfWidgetPadding on List<Widget> {
  List<Widget> paddingList({
    double? bottom,
    double? left,
    double? right,
    double? top,
  }) {
    return map(
      (e) => Padding(
        padding: EdgeInsets.only(
          bottom: bottom ?? 0,
          left: left ?? 0,
          right: right ?? 0,
          top: top ?? 0,
        ),
        child: e,
      ),
    ).toList();
  }
}
