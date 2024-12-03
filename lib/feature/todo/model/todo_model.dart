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
    Database db = await SqfliteDatabaseHelper.database;
    todo.id = await db.insert("todo", todo.toMap());
    print("Todo added to database ${todo.id}");
    return todo;
  }

  static Future<List<TodoModel>> getAllTodo() async {
    Database db = await SqfliteDatabaseHelper.database;
    List<Map<String, Object?>> records = await db.query('todo');
    List<TodoModel> todos = records.map((e) => TodoModel.fromMap(e)).toList();
    return todos;
  }
}
