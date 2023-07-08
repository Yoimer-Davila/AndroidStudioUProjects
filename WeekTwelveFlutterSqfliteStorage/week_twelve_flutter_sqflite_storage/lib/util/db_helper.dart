import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:week_twelve_flutter_sqflite_storage/models/shopping_list.dart';
import 'package:week_twelve_flutter_sqflite_storage/models/list_items.dart';

class DbHelper {
  final int version;
  final String name;
  Database? db;
  

  static final DbHelper instance = DbHelper._internal();
  DbHelper._internal({this.name='shopping.db', this.version = 1});

  factory DbHelper() {
    return instance;
  }

  Future<Database> open() async {
    db ??= await openDatabase(
        join(await getDatabasesPath(), name,),
        onCreate: (database, version) {
          database.execute("CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)");
          database.execute("CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity TEXT, note TEXT, "
              "FOREIGN KEY(idList) REFERENCES lists(id))");
        },
        version: version
      );
    return db!;
  }

  Future query(String sql) async => await db!.rawQuery(sql);
  Future execute(String sql) async => await db!.execute(sql);
  Future selectAllFrom(String tableName) async => await query("SELECT * FROM $tableName");
  Future<int> _insertInto(String name, Map<String, dynamic> values) async => await db!.insert(name, values, conflictAlgorithm: ConflictAlgorithm.replace);
  Future<int> insertList(ShoppingList list) async => await _insertInto("lists", list.map());
  Future<int> insertListItem(ListItem item) async => await _insertInto("items", item.map());

  Future<List<ShoppingList>> lists() async {
    final List<Map<String, dynamic>> maps = await db!.query("lists");
    return List.generate(maps.length, (index) => ShoppingList.fromMap(maps[index]));
  }

  Future<List<ListItem>> items() async {
    final List<Map<String, dynamic>> maps = await db!.query("items");
    return List.generate(maps.length, (index) => ListItem.fromMap(maps[index]));
  }

  Future<List<ListItem>> itemsSwitchList(int idList) async {
    final List<Map<String, dynamic>> maps = await db!.query("items", where: "idList = ?", whereArgs: [idList]);
    return List.generate(maps.length, (index) => ListItem.fromMap(maps[index]));
  }
}