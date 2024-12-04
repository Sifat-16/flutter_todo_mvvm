import 'package:flutter_todo_mvvm/feature/todo/model/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todoDatabase.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todoInfo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        isSelected INTEGER NOT NULL DEFAULT 0,
        hexColor TEXT
      )
    ''');
  }

  static Future<int> insertUser(TodoModel user) async {
    Database db = await instance.db;
    return await db.insert('todoInfo', user.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await instance.db;
    return await db.query('todoInfo');
  }

  static Future<int> updateUser(TodoModel user) async {
    Database db = await instance.db;
    return await db.update('todoInfo', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<int> deleteUser(TodoModel user) async {
    Database db = await instance.db;
    return await db.delete('todoInfo', where: 'id = ?', whereArgs: [user.id]);
  }
}
