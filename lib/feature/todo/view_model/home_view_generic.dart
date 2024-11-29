import 'package:flutter/material.dart';
import 'package:flutter_todo_mvvm/feature/todo/model/todo_model.dart';

class HomeViewGeneric {
  bool isLoading;
  List<TodoModel> todos;
  Color pickerColor;

  HomeViewGeneric(
      {this.todos = const [],
      this.isLoading = false,
      this.pickerColor = const Color(0xff443a49)});

  HomeViewGeneric update(
      {
        List<TodoModel>? todos,
        bool? isLoading,
        Color? pickerColor
      }
      ) {
    return HomeViewGeneric(
        todos: todos ?? this.todos,
        isLoading: isLoading ?? this.isLoading,
        pickerColor: pickerColor ?? this.pickerColor);
  }
}
