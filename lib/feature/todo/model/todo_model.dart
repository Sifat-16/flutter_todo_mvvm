import 'package:flutter_todo_mvvm/config/database/local/database_helper.dart';
import 'package:sqflite/sqlite_api.dart';

class TodoModel {
  int? id;
  String title;
  bool isSelected;
  String? hexColor;
  TodoModel({this.id, required this.title, this.isSelected = false, this.hexColor});

  // Convert TodoModel to a map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isSelected': isSelected ? 1 : 0, // Convert bool to int for SQLite
      'hexColor': hexColor,
    };
  }

  // Create TodoModel from a map (database row)
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      isSelected: map['isSelected'] == 1, // Convert int to bool
      hexColor: map['hexColor'] as String?,
    );
  }
}

class todoProvider1{

  static const String createTable = '''
      CREATE TABLE todoInfo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        isSelected INTEGER NOT NULL DEFAULT 0,
        hexColor TEXT
      )
    ''';

  static Future<int> insertUser(TodoModel user) async {
    Database db = await DatabaseHelper.db;
    return await db.insert('todoInfo', user.toMap());
  }

  static Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await DatabaseHelper.db;
    return await db.query('todoInfo');
  }

  static Future<int> updateUser(TodoModel user) async {
    Database db = await DatabaseHelper.db;
    return await db.update('todoInfo', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<int> deleteUser(TodoModel user) async {
    Database db = await DatabaseHelper.db;
    return await db.delete('todoInfo', where: 'id = ?', whereArgs: [user.id]);
  }
}