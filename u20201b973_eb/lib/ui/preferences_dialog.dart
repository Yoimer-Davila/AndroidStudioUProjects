import 'package:flutter/material.dart';
import 'package:u20201b973_eb/util/app_preferences.dart';
import 'package:u20201b973_eb/util/stylers.dart' as styler;

class PreferencesDialog {
  final AppPreferences preferences = AppPreferences();

  static final instance = PreferencesDialog._internal();
  PreferencesDialog._internal();
  factory PreferencesDialog() => instance;

  Widget buildDialog() {
    return AlertDialog(
      content: styler.withPadding(
        widget: Card(
          elevation: 2,
          shadowColor: Colors.grey,
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Total price: ${preferences.getProductsPrice()}"),
                Text("Total stock: ${preferences.getProductsStock()}")
              ],
            ),
          ),
        )
      ),
    );
  }
}