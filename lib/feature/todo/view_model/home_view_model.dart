import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/model/todo_model.dart';
import 'package:flutter_todo_mvvm/feature/todo/view_model/home_view_generic.dart';

final homeProvider = StateNotifierProvider<HomeController, HomeViewGeneric>(
    (ref) => HomeController());

class HomeController extends StateNotifier<HomeViewGeneric> {
  HomeController() : super(HomeViewGeneric());

  addTodo({required String title}) {
    TodoModel newTodoModel = TodoModel(title: title);
    List<TodoModel> todos = [...state.todos, newTodoModel];
    state = state.update(todos: todos);
  }

  toggleSelected({required bool selected, required int index}) {
    List<TodoModel> todos = state.todos;
    todos[index].isSelected = selected;
    state = state.update(todos: todos);
  }

  deleteTodo({required int index}) {
    List<TodoModel> todos = state.todos;
    todos.removeAt(index);
    state = state.update(todos: todos);
  }

  updateColor({required String hexColor, required int index}) {
    List<TodoModel> todos = state.todos;
    todos[index].hexColor = hexColor;
    state = state.update(todos: todos);
  }
}
