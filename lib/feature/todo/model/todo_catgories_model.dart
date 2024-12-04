import 'package:flutter_todo_mvvm/config/database/local/database_helper.dart';
import 'package:sqflite/sqlite_api.dart';

class TodoCategoryModel{
  int? id;
  String title;
  String category;
  String? description;
  String? importance;
  TodoCategoryModel({this.id, required this.title, required this.category, this.description, this.importance});

  // Convert a TodoCategoryModel into a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'importance': importance,
    };
  }

  // Convert a Map into a TodoCategoryModel for (database row)
  static TodoCategoryModel fromMap(Map<String, dynamic> map) {
    return TodoCategoryModel(
      id: map['id'] as int?,  // 'id' can be null, so we cast to int?
      title: map['title'] as String,  // 'title' is a required String
      category: map['category'] as String,  // 'category' should be a String
      description: map['description'] as String?,  // 'description' is optional, so it's nullable
      importance: map['importance'] as String?,  // 'importance' is optional, so it's nullable
    );
  }
}

class todoProvider2{
  static const String createTodoCategoriesTable = '''
    CREATE TABLE todo_categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      category TEXT NOT NULL,
      description TEXT,
      importance TEXT
    );
  ''';

  static Future<int> insertUser(TodoCategoryModel user) async {
    Database db = await DatabaseHelper.db;
    return await db.insert('todo_categories', user.toMap());
  }

  static Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await DatabaseHelper.db;
    return await db.query('todo_categories');
  }

  static Future<int> updateUser(TodoCategoryModel user) async {
    Database db = await DatabaseHelper.db;
    return await db.update('todo_categories', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<int> deleteUser(TodoCategoryModel user) async {
    Database db = await DatabaseHelper.db;
    return await db.delete('todo_categories', where: 'id = ?', whereArgs: [user.id]);
  }
}

