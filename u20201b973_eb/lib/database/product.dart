import 'package:drift/drift.dart';
import 'package:u20201b973_eb/database/shared.dart';

class Products extends IndexableTable {
  TextColumn get title => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  IntColumn get stock => integer()();
  TextColumn get thumbnail => text()();
  BoolColumn get isFavorite => boolean().nullable()();
}