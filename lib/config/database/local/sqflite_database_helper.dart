import 'package:flutter_todo_mvvm/feature/todo/model/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseHelper {
  static final _databaseName = "todo_mvvm.db";
  static final _databaseVersion = 2;
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: (db, version) async {},
        onUpgrade: (db, oldVersion, newVersion) async {
      print("Database is upgrading!!!");

      if (newVersion == 2) {
        print("Creating todo table");
        await db.execute(TodoProvider.createTodoTableQuery);
      }
    });
  }
}
