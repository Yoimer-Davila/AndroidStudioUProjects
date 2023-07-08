import 'package:flutter/material.dart';
import 'package:week_twelve_flutter_sqflite_storage/models/list_items.dart';
import 'package:week_twelve_flutter_sqflite_storage/util/db_helper.dart';

class ListItemDialog {
  final textName = TextEditingController();
  final textQuantity = TextEditingController();
  final textNote = TextEditingController();
  ListItemDialog();

  void cleanControllers() {
    textQuantity.text = "";
    textNote.text = "";
    textName.text = "";
  }

  Widget buildDialog(BuildContext context, ListItem item, bool isNew) {
    DbHelper helper = DbHelper();
    if(!isNew) {
      textName.text = item.name;
      textQuantity.text = item.quantity;
      textNote.text = item.note;
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
              controller: textQuantity,
              decoration: const InputDecoration(
                  hintText: "Item Quantity"
              ),
            ),
            TextField(
              controller: textNote,
              decoration: const InputDecoration(
                hintText: "Item Notes"
              ),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                item.name = textName.text;
                item.note = textNote.text;
                item.quantity = textQuantity.text;
                helper.insertListItem(item);
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