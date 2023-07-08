import 'package:week_twelve_flutter_sqflite_storage/util/converters.dart';

class ShoppingList {
  final int id;
  String name;
  int priority;

  ShoppingList(this.id, this.name, this.priority);

  Map<String, dynamic> map() {
    return {
      'id': (id == 0) ? null : id,
      'name': name,
      'priority': priority
    };
  }

  static ShoppingList fromMap(Map json) => ShoppingList(
      fromJson(json, 'id'),
      fromJson(json, 'name'),
      fromJson(json, 'priority')
  );

  static ShoppingList empty = ShoppingList(0, "", 0);

}