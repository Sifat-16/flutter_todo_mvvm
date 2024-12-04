import 'package:flutter_todo_mvvm/feature/todo/model/todo_catgories_model.dart';

class CategoryViewGenerics{
  List<TodoCategoryModel> categoryTodo;
  CategoryViewGenerics({this.categoryTodo = const []});

  CategoryViewGenerics update({List<TodoCategoryModel>? todos}) {
    return CategoryViewGenerics(
        categoryTodo: todos ?? this.categoryTodo,
    );
  }
}