import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/category_view_model/category_view_model.dart';

class AddCategories extends ConsumerStatefulWidget {
  const AddCategories({super.key});

  @override
  ConsumerState<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends ConsumerState<AddCategories> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _importanceController = TextEditingController();

  @override
  void dispose() {
    //_focusNode.dispose(); // Clean up the focus node when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                // suffixIcon: IconButton(
                //     onPressed: () async {
                //       await ref.read(homeProvider.notifier).addTodo(title: todoAddController.text.trim());
                //       todoAddController.clear();
                //
                //       print("length = ${ref.read(homeProvider).todos.length}");
                //       print("Current ttt = ${ref.read(homeProvider).todos[ref.read(homeProvider).todos.length - 1]}");
                //
                //       await showTodoColorDialog(index: ref.read(homeProvider).todos.length - 1);
                //       //ColorSelect cur = ColorSelect(ctx: context, pickedColor: ref.read(homeProvider).pickerColor,);
                //       //await cur.showTodoColorDialog(index: ref.read(homeProvider).todos.length - 1);
                //       _focusNode.unfocus();
                //       print("OK");
                //       Navigator.of(context).pop();
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text('Post successfully added!'),
                //           duration: Duration(seconds: 4),
                //           // Duration the snackbar is shown
                //           backgroundColor: Colors.green, // Background color of the SnackBar
                //           //behavior: SnackBarBehavior.floating,
                //           //margin: EdgeInsets.only(bottom: 100),
                //         ),
                //       );
                //     },
                //     icon: Icon(Icons.send)
                // ),
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
            SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green)
              ),
              onPressed: () async{
                await ref.read(categoryProvider.notifier).addTodo(title: _titleController.text.trim(), category: "x", importance: _importanceController.text.trim(), description: _descriptionController.text.trim());
                _descriptionController.clear();
                _importanceController.clear();
                _titleController.clear();

                print("OK");
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Post successfully added!'),
                    duration: Duration(seconds: 4),
                    // Duration the snackbar is shown
                    backgroundColor: Colors.green, // Background color of the SnackBar
                    //behavior: SnackBarBehavior.floating,
                    //margin: EdgeInsets.only(bottom: 100),
                  ),
                );
              },
              child: Text("Insert", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400),),
            )
          ],
        ),
      ),
    );
  }
}
