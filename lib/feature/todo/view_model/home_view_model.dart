import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/model/todo_model.dart';
import 'package:flutter_todo_mvvm/feature/todo/view_model/home_view_generic.dart';

final homeProvider = StateNotifierProvider<HomeController, HomeViewGeneric>(
    (ref) => HomeController());

class HomeController extends StateNotifier<HomeViewGeneric> {
  HomeController() : super(HomeViewGeneric());

  addTodo({required String title,required String hexcolor}) async {
    TodoModel newTodoModel = TodoModel(title: title,hexColor: hexcolor);
   /// TodoModel newTodoModel = TodoModel(title: title);
    await TodoProvider.insert(newTodoModel);
    // List<TodoModel> todos = [...state.todos, newTodoModel];
    getTodo();
  }

  getTodo() async {
    List<TodoModel> todos = await TodoProvider.getAllTodo();
    todos.forEach((e){
      print("id:${e.id} Title: ${e.title} selected:${e.isSelected} Color: ${e.hexColor}");
    });
    state = state.update(todos: todos);

  }

  toggleSelected({required bool selected, required int index}) {
    List<TodoModel> todos = state.todos;
    todos[index].isSelected = selected;
    updatetodo(index: index, isSelected: selected);
    state = state.update(todos: todos);
  }

  deleteTodo({required int index}) async {
    List<TodoModel> todos = state.todos;
    int? id = todos[index].id;  // Get the ID of the item to delete

    if (id != null) {
      // Remove from the database
      await TodoProvider.delete(id: id);
    }
    todos.removeAt(index);
    state = state.update(todos: todos);
  }

  updatetodo({ String? hexColor, String? title, required int index, bool? isSelected}) async {
    List<TodoModel> todos = state.todos;
    if(hexColor != null)todos[index].hexColor = hexColor; // Update the local state
    if(isSelected != null)todos[index].isSelected = isSelected;

    await TodoProvider.updateTodo(todo: todos[index]); // Update the database
    state = state.update(todos: todos);
  }
}






final categoryProvider = StateNotifierProvider<CategoryController, CategoryViewGeneric>(
        (ref) => CategoryController());

class CategoryController extends StateNotifier<CategoryViewGeneric> {
  CategoryController() : super(CategoryViewGeneric());

  addCategory({required String title}) async {
    CategoryModel newCategoryModel = CategoryModel(title: title,);
    /// TodoModel newTodoModel = TodoModel(title: title);
    await CategoryProvider.insert(newCategoryModel);
    // List<TodoModel> todos = [...state.todos, newTodoModel];
    getCategory();
  }



  getCategory() async {
    List<CategoryModel> categories = await CategoryProvider.getAllCategory();
    state = state.update(categories: categories);

  }


}

