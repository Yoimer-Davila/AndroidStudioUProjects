import 'package:week_twelve_flutter_sqflite_storage/util/converters.dart';

class ListItem {
  final int id;
  final int idList;
  String name;
  String quantity;
  String note;


  ListItem(this.id, this.idList, this.name, this.quantity, this.note);

  Map<String, dynamic> map() {
    return {
      'id': (id == 0) ? null : id,
      'idList': idList,
      'name': name,
      'quantity': quantity,
      'note': note
    };
  }
  static ListItem fromMap(Map json) => ListItem(
      fromJson(json, "id"),
      fromJson(json, "idList"),
      fromJson(json, "name"),
      fromJson(json, "quantity"),
      fromJson(json, "note")
  );

  static ListItem empty(int idList) => ListItem(0, idList, "", "", "");
}