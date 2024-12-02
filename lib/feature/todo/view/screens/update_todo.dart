import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/home_view_model.dart';

class UpdateTodo extends ConsumerStatefulWidget{
  final int currentIndex;
  const UpdateTodo({super.key, required this.currentIndex});

  @override
  ConsumerState<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends ConsumerState<UpdateTodo> {

  TextEditingController todoAddController = TextEditingController();

  @override
  void initState() {
    todoAddController.text = ref.read(homeProvider).todos[widget.currentIndex].title;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios_new, color: Colors.orange,)
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: (){
                  ref.read(homeProvider.notifier).updateText(editTitle: todoAddController.text.trim(), index: widget.currentIndex);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully edited!'),
                      duration: Duration(seconds: 4),  // Duration the snackbar is shown
                      backgroundColor: Colors.green,  // Background color of the SnackBar
                      //behavior: SnackBarBehavior.floating,
                      //margin: EdgeInsets.only(bottom: 100),
                    ),
                  );
                },
                child: Text("Save", style: TextStyle(fontSize: 22, color: Colors.orange),)
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: TextField(
            controller: todoAddController,
            maxLines: 100,
            minLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }
}
