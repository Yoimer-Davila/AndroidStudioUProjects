import 'package:flutter/material.dart';
import 'package:week_twelve_flutter_sqflite_storage/ui/list_item_dialog.dart';
import 'package:week_twelve_flutter_sqflite_storage/util/db_helper.dart';
import 'package:week_twelve_flutter_sqflite_storage/models/shopping_list.dart';
import 'package:week_twelve_flutter_sqflite_storage/models/list_items.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key, required this.list});
  final ShoppingList list;
  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  DbHelper helper = DbHelper();
  List<ListItem> items = [];
  late ListItemDialog listItemDialog;

  Future showData(int idList) async {
    helper.open();
    final items = await helper.itemsSwitchList(idList);
    setState(() {
      this.items = items;
    });
  }

  void showInsertDialog(ListItem item, bool isNew) {
    showDialog(
      context: context,
      builder: (context) => listItemDialog.buildDialog(context, item, isNew)
    );
  }

  ListTile builtItem(ListItem item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text("Quantity: ${item.quantity} - Note: ${item.note}"),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => showInsertDialog(item, false)

      ),
    );
  }

  @override
  void initState() {
    super.initState();
    listItemDialog = ListItemDialog();
  }

  @override
  Widget build(BuildContext context) {
    showData(widget.list.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list.name),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => builtItem(items[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showInsertDialog(ListItem.empty(widget.list.id), true),
      ),
    );
  }
}
