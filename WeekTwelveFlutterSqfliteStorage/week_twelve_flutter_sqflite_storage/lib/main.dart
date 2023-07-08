import 'package:flutter/material.dart';
import 'package:week_twelve_flutter_sqflite_storage/ui/items_screen.dart';
import 'package:week_twelve_flutter_sqflite_storage/util/db_helper.dart';
import 'package:week_twelve_flutter_sqflite_storage/models/shopping_list.dart';
import 'package:week_twelve_flutter_sqflite_storage/models/list_items.dart';
import 'package:week_twelve_flutter_sqflite_storage/ui/shopping_list_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const ShowList()
    );
  }
}

class ShowList extends StatefulWidget {
  const ShowList({super.key});

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  final DbHelper helper = DbHelper();
  List<ShoppingList> list = [];
  late ShoppingListDialog insertDialog;
  @override
  void initState() {
    initDatabase().then((value) => null);
    insertDialog = ShoppingListDialog();
    super.initState();
  }

  void addInsert(ShoppingList list) {
    setState(() {
      this.list.add(list);
    });
  }

  void showInsertDialog(BuildContext context, ShoppingList item, bool isNew) {
    showDialog(
        context: context,
        builder: (context) => insertDialog.buildDialog(context, item, isNew)
    );
  }

  void toItem(ShoppingList list) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ItemsScreen(list: list)));
  }

  Widget shoppingList(ShoppingList item) {
    return ListTile(
      title: Text(item.name),
      leading: CircleAvatar(
        child: Text(item.priority.toString()),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => showInsertDialog(context, item, false),
      ),
      onTap: () => toItem(item),
    );
  }

  @override
  Widget build(BuildContext context) {
    initDatabase().then((value) => null);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => shoppingList(list[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showInsertDialog(context, ShoppingList.empty, true),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future initDatabase() async {
    await helper.open();
    final shopping = await helper.lists();
    setState(() {
      list = shopping;
    });
  }
}
