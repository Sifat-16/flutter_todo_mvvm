import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/category_view_model/category_view_generics.dart';
import 'package:flutter_todo_mvvm/feature/todo/model/todo_catgories_model.dart';

final categoryProvider = StateNotifierProvider<CategoryController, CategoryViewGenerics> ((r) => CategoryController());

class CategoryController extends StateNotifier<CategoryViewGenerics> {
  CategoryController() : super(CategoryViewGenerics());

  todoInitialize() async{
    final todoDataFetch = await todoProvider2.queryAllUsers();
    List<TodoCategoryModel> todos1 = todoDataFetch.map((currentTodo) => TodoCategoryModel.fromMap(currentTodo)).toList();
    state = state.update(todos: todos1);
  }

  addTodo({required String title, required String category, required String importance, required String description}) async{
    TodoCategoryModel newCategoryTodoModel = TodoCategoryModel(title: title, category: category, importance: importance, description: description);
    await todoProvider2.insertUser(newCategoryTodoModel);
    //List<TodoModel> todos1 = [...state.todos, newTodoModel];
    final todoDataFetch = await todoProvider2.queryAllUsers();
    List<TodoCategoryModel> todos1 = todoDataFetch.map((currentTodo) => TodoCategoryModel.fromMap(currentTodo)).toList();
    state = state.update(todos: todos1);
  }

  deleteTodo({required int index}) async{
    List<TodoCategoryModel> todos1 = state.categoryTodo;
    await todoProvider2.deleteUser(todos1[index]);
    todos1.removeAt(index);
    state = state.update(todos: todos1);
  }

  updateText({required String editTitle, required int index}) async{
    List<TodoCategoryModel> todos1 = state.categoryTodo;
    todos1[index].title = editTitle;
    state = state.update(todos: todos1);
    await todoProvider2.updateUser(todos1[index]);
  }
}