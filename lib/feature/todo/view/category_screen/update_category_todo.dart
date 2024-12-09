import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/category_view_model/category_view_model.dart';

class UpdateCategoryTodo extends ConsumerStatefulWidget {
  final int currentIndex;
  const UpdateCategoryTodo({super.key, required this.currentIndex});

  @override
  ConsumerState<UpdateCategoryTodo> createState() => _UpdateCategoryTodoState();
}

class _UpdateCategoryTodoState extends ConsumerState<UpdateCategoryTodo> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _importanceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = ref.read(categoryProvider).categoryTodo[widget.currentIndex].title;
    _descriptionController.text = ref.read(categoryProvider).categoryTodo[widget.currentIndex].description!;
    _importanceController.text = ref.read(categoryProvider).categoryTodo[widget.currentIndex].importance!;
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
                  ref.read(categoryProvider.notifier).updateText(index: widget.currentIndex, title: _titleController.text.trim(), importance: _importanceController.text.trim(), description: _descriptionController.text.trim());
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
        child: Column(
          children: [
            Text("Title:", style: TextStyle(fontSize: 22, color: Colors.blueAccent),),
            SizedBox(height: 10),
            TextField(
              controller: _titleController,
              maxLines: 1,
              minLines: 1,
              //focusNode: _focusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 40),
            Text("Importance:", style: TextStyle(fontSize: 22, color: Colors.blueAccent),),
            SizedBox(height: 10),
            TextField(
              controller: _importanceController,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 40),
            Text("Description:", style: TextStyle(fontSize: 22, color: Colors.blueAccent),),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 6,
              minLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
