import 'package:flutter/material.dart';
import 'package:week_twelve_flutter_sqflite_storage/util/db_helper.dart';
import 'package:week_twelve_flutter_sqflite_storage/models/shopping_list.dart';

class ShoppingListDialog {
  final textName = TextEditingController();
  final textPriority = TextEditingController();
  ShoppingListDialog();

  void cleanControllers() {
    textPriority.text = "";
    textName.text = "";
  }

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    DbHelper helper = DbHelper();
    if(!isNew) {
      textName.text = list.name;
      textPriority.text = list.priority.toString();
    }

    return AlertDialog(
      title: Text(isNew ? "New Item" : "Update Item"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: textName,
              decoration: const InputDecoration(
                hintText: "Item Name",
              ),
            ),
            TextField(
              controller: textPriority,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Item Priority"
              ),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                list.name = textName.text;
                list.priority = int.parse(textPriority.text);
                helper.insertList(list);
                cleanControllers();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

}