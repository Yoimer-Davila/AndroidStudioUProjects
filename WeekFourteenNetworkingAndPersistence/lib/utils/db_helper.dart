import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:week_fourteen_networking_and_persistence/models/movie.dart';
import 'package:week_fourteen_networking_and_persistence/utils/converters.dart';

class DbHelper {
  int version;
  String name;

  Database? db;

  bool get isOpen => db != null;
  bool get isNotOpen => !isOpen;

  static final DbHelper instance = DbHelper._internal();
  DbHelper._internal({this.name='db.db', this.version = 1});

  factory DbHelper() => instance;

  Future<int> _insertInto(String name, Map<String, dynamic> values) async => await db!.insert(name, values, conflictAlgorithm: ConflictAlgorithm.replace);
  Future<Map<String, dynamic>?> _findFromId(String name, int id) async {
    if(isNotOpen){
      return null;
    }

    final response = await db!.query(name, where: "id = ?", whereArgs: [id]);
    return response.first;
  }
  Future<int> _deleteFromId(String name, int id) async {
    if(isNotOpen){
      return 0;
    }
    return await db!.delete(name, where: "id = ?", whereArgs: [id]);
  }
  Future<Database> open() async {
    db ??= await openDatabase(
        join(await getDatabasesPath(), name,),
        onCreate: (database, version) {
          database.execute("CREATE TABLE movies(id INTEGER PRIMARY KEY, title TEXT)");
        },
        version: version
    );
    return db!;
  }
  void openAndExecute({required Function consumer}) => andThen(open(), then: consumer);
  void executeIfOrOpen({required Function consumer}) {
    if(isNotOpen){
      openAndExecute(consumer: consumer);
    } else {
      consumer();
    }
  }
  void changeDatabaseName(String name) {
    if(isNotOpen){
      this.name = name.endsWith(".db") ? name : "$name.db";
    }
  }
  void changeDatabaseVersion(int version) {
    if(isNotOpen){
      this.version = version;
    }
  }



  Future<int> insertMovie(Movie movie) async => await _insertInto("movies", movie.toMap());
  Future<bool> isFavoriteMovie(Movie movie) async => (await _findFromId("movies", movie.id)) != null;
  Future<int> deleteMovie(Movie movie) async => await _deleteFromId("movies", movie.id);

}