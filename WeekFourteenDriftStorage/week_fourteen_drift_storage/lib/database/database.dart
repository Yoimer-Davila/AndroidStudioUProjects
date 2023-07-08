import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

// dart run build_runner build
part 'database.g.dart';

abstract class IndexableTable extends Table {
  IntColumn get id => integer().autoIncrement()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

class Users extends IndexableTable {
  TextColumn get name => text()();
  TextColumn get mail => text()();
}

class Mails extends Table {
  IntColumn get userId => integer().references(Users, #id)();
}



@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(beforeOpen: (details) async => await customStatement("PRAGMA foreign_keys = ON"));

  //Future<User?> _findById(int id) async => (select(users)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<Ty?> _findById<Ty>(TableInfo<IndexableTable, Ty> table, int id) async => await where(table, (p0) => p0.id.equals(id)).getSingleOrNull();
  Future<List<Ty>> _findAll<Ty>(TableInfo<Table, Ty> table) async => await select(table).get();
  Future<int> _insert<Ty>(TableInfo<Table, Ty> table, UpdateCompanion<Ty> entity) async => await into(table).insert(entity);
  Future<bool> _update<Ty>(TableInfo<Table, Ty> table, UpdateCompanion<Ty> entity) async => await update(table).replace(entity);
  Future<int> _delete<Ty>(TableInfo<Table, Ty> table, UpdateCompanion<Ty> entity) async => await delete(table).delete(entity);
  Selectable<Ty> where<Tab extends Table, Ty>(TableInfo<Tab, Ty> table, Expression<bool> Function(Tab) selector) => select(table)..where((tbl) => selector(tbl));


  Future<List<User>> listUsers() async => await _findAll(users);
  Future<int> insertUser(UsersCompanion userCompanion) async => await _insert(users, userCompanion);
  Future<int> deleteUser(UsersCompanion userCompanion) async => await _delete(users, userCompanion);
  Future<bool> updateUser(UsersCompanion userCompanion) async => await _update(users, userCompanion);

}