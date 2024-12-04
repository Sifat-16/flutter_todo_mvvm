import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/config/database/local/database_helper.dart';
import 'package:flutter_todo_mvvm/feature/todo/model/todo_model.dart';
import 'package:flutter_todo_mvvm/feature/todo/view_model/home_view_generic.dart';

final homeProvider = StateNotifierProvider<HomeController, HomeViewGeneric>((ref) => HomeController());

class HomeController extends StateNotifier<HomeViewGeneric> {
  HomeController() : super(HomeViewGeneric());

  todoInitialize() async{
    final todoDataFetch = await DatabaseHelper.instance.queryAllUsers();
    List<TodoModel> todos1 = todoDataFetch.map((currentTodo) => TodoModel.fromMap(currentTodo)).toList();
    state = state.update(todos: todos1);
  }

  addTodo({required String title}) async{
    TodoModel newTodoModel = TodoModel(title: title);
    await DatabaseHelper.insertUser(newTodoModel);
    //List<TodoModel> todos1 = [...state.todos, newTodoModel];
    final todoDataFetch = await DatabaseHelper.instance.queryAllUsers();
    List<TodoModel> todos1 = todoDataFetch.map((currentTodo) => TodoModel.fromMap(currentTodo)).toList();
    state = state.update(todos: todos1);
  }

  toggleSelected({required bool selected, required int index}) {
    List<TodoModel> todos1 = state.todos;
    todos1[index].isSelected = selected;
    state = state.update(todos: todos1);
  }

  deleteTodo({required int index}) async{
    List<TodoModel> todos1 = state.todos;
    await DatabaseHelper.deleteUser(todos1[index]);
    todos1.removeAt(index);
    state = state.update(todos: todos1);
  }

  updateColor({required String hexColor, required int index}) async{
    List<TodoModel> todos1 = state.todos;
    todos1[index].hexColor = hexColor;
    state = state.update(todos: todos1);
    await DatabaseHelper.updateUser(todos1[index]);
    state = state.update(todos: todos1);
  }

  updateText({required String editTitle, required int index}) async{
    List<TodoModel> todos1 = state.todos;
    todos1[index].title = editTitle;
    state = state.update(todos: todos1);
    await DatabaseHelper.updateUser(todos1[index]);
  }
}