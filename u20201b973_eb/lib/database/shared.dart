import 'package:drift/drift.dart';

abstract class IndexableTable extends Table {
  IntColumn get id => integer().autoIncrement()();
}