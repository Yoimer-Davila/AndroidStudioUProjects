import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:u20201b973_eb/database/product.dart';
import 'package:u20201b973_eb/database/shared.dart';

// dart run build_runner build
part 'database.g.dart';


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Products])
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /*
  @override
  MigrationStrategy get migration => MigrationStrategy(beforeOpen: (details) async => await customStatement("PRAGMA foreign_keys = ON"));
  * */

  //Future<User?> _findById(int id) async => (select(users)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<Ty?> _findById<Ty>(TableInfo<IndexableTable, Ty> table, int id) async => await where(table, (p0) => p0.id.equals(id)).getSingleOrNull();
  Future<List<Ty>> _findAll<Ty>(TableInfo<Table, Ty> table) async => await select(table).get();
  Future<int> _insert<Ty>(TableInfo<Table, Ty> table, UpdateCompanion<Ty> entity) async => await into(table).insert(entity);
  Future<bool> _update<Ty>(TableInfo<Table, Ty> table, UpdateCompanion<Ty> entity) async => await update(table).replace(entity);
  Future<int> _delete<Ty>(TableInfo<Table, Ty> table, UpdateCompanion<Ty> entity) async => await delete(table).delete(entity);
  Selectable<Ty> where<Tab extends Table, Ty>(TableInfo<Tab, Ty> table, Expression<bool> Function(Tab) selector) => select(table)..where((tbl) => selector(tbl));

  Future<List<Product>> listProducts() async => await _findAll(products);
  Future<bool> productIsFavorite(Product product) async => await (_findById(products, product.id)) != null;
  Future<int> insertProduct(ProductsCompanion companion) async => await _insert(products, companion);
  Future<int> deleteProduct(ProductsCompanion companion) async => await _delete(products, companion);

}