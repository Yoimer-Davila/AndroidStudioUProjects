import 'package:flutter/material.dart';

Future<Ty?> to<Ty>(BuildContext context, Widget objective) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => objective));

void back<Ty>(BuildContext context, [Ty? result]) => Navigator.pop(context, result);