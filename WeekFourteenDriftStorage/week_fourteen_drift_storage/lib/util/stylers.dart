import 'package:flutter/material.dart';

Widget withPadding({Widget? widget, EdgeInsets padding = const EdgeInsets.all(10)}) => Padding(
  padding: padding,
  child: widget,
);

EdgeInsets leftRightPadding({double value = 8}) => EdgeInsets.only(left: value, right: value);
EdgeInsets topBottomPadding({double value = 8}) => EdgeInsets.only(top: value, bottom: value);
EdgeInsets allPadding({double value = 8}) => EdgeInsets.all(value);
EdgeInsets horVerPadding({double horizontal = 8, double vertical = 8}) => EdgeInsets.only(left: horizontal, right: horizontal, top: vertical, bottom: vertical);
