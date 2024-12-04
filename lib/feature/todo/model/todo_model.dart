import 'package:flutter/foundation.dart';
import 'package:flutter_todo_mvvm/config/database/local/sqflite_database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TodoModel {
  int? id;
  String title;
  bool isSelected;
  String? hexColor;

  TodoModel(
      {this.id, required this.title, this.isSelected = false, this.hexColor});

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

class TodoProvider {
  static const String createTodoTableQuery = '''
    CREATE TABLE todo (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      isSelected INTEGER NOT NULL DEFAULT 0,
      hexColor TEXT
    )
    ''';

  static Future<TodoModel> insert(TodoModel todo) async {
    print("===> ${todo.hexColor}");
    Database db = await SqfliteDatabaseHelper.database;
    todo.id = await db.insert("todo", todo.toMap());
    print("Todo added to database ${todo.id}");
    return todo;
  }

  static Future<List<TodoModel>> getAllTodo() async {
    Database db = await SqfliteDatabaseHelper.database;
    List<Map<String, Object?>> records = await db.query('todo');
    print(records);
    List<TodoModel> todos = records.map((e) => TodoModel.fromMap(e)).toList();
    return todos;
  }

  static Future<void> updateTodo({required TodoModel todo}) async {
    Database db = await SqfliteDatabaseHelper.database;

    // Update the hexColor in the database
    await db.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  static Future<void> delete({required int id}) async {
    Database db = await SqfliteDatabaseHelper.database;

    // Delete the record with the given ID
    await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class CategoryModel {
  int? id;
  String title;
  String? description;
  String? importance;

  CategoryModel(
      {this.id,
      required this.title,
       this.description,
        this.importance});

  // Convert categoryModel to a map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description, // Convert bool to int for SQLite
      'importance': importance,
    };
  }

  // Create categoryModel from a map (database row)
  factory CategoryModel.fromMap(Map<String, dynamic> categorymap) {
    return CategoryModel(
      id: categorymap['id'] as int?,
      title: categorymap['title'] as String,
      description: categorymap['description'] as String?,
      importance: categorymap['importance'] as String?,
    );
  }
}

class CategoryProvider {
  static const String createCategoryTableQuery = '''
    CREATE TABLE category (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NULL,
      importance TEXT NULL
    )
    ''';

  static const String dropCategoryTableQuery = '''
    DROP TABLE category
    ''';

  static Future<CategoryModel> insert(CategoryModel category) async {


    Database db = await SqfliteDatabaseHelper.database;
    category.id = await db.insert("category", category.toMap());
    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");

    return category;
  }


  static Future<List<CategoryModel>> getAllCategory() async {
    Database db = await SqfliteDatabaseHelper.database;
    List<Map<String, Object?>> records = await db.query('category');
    print(records);
    List<CategoryModel> categories =
        records.map((e) => CategoryModel.fromMap(e)).toList();
    return categories;
  }

  static Future<void> updateCategory({required CategoryModel category}) async {
    Database db = await SqfliteDatabaseHelper.database;

    // Update the hexColor in the database
    await db.update(
      'category',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  static Future<void> delete({required int id}) async {
    Database db = await SqfliteDatabaseHelper.database;

    // Delete the record with the given ID
    await db.delete(
      'category',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}


