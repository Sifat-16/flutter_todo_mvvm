import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_model/home_view_model.dart';

class NewTodoAdd extends ConsumerStatefulWidget {
  const NewTodoAdd({super.key});

  @override
  ConsumerState<NewTodoAdd> createState() => _NewTodoAddState();
}

class _NewTodoAddState extends ConsumerState<NewTodoAdd> {
  Future<void> showTodoColorDialog({required int index}) async {
    Color? chosenColor;
    // raise the [showDialog] widget
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: ref.read(homeProvider).pickerColor,
              onColorChanged: (Color color) {
                chosenColor = color;
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                chosenColor = null;
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );

    if (chosenColor != null) {
      ref.read(homeProvider.notifier).updateColor(hexColor: chosenColor!.toHexString(), index: index);
      print("if: ${ref.watch(homeProvider).todos[index].hexColor}");
      print("if ${ref.watch(homeProvider).todos[index].title}");
    } else{
      print("else : ${ref.watch(homeProvider).todos[index].hexColor}");
    }

    print("Chosen color ${chosenColor?.toHexString()}");
  }

  TextEditingController todoAddController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose(); // Clean up the focus node when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: TextField(
            controller: todoAddController,
            maxLines: 4,
            minLines: 1,
            focusNode: _focusNode,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () async {
                    await ref.read(homeProvider.notifier).addTodo(title: todoAddController.text.trim());
                    todoAddController.clear();

                    print("length = ${ref.read(homeProvider).todos.length}");
                    print("Current ttt = ${ref.read(homeProvider).todos[ref.read(homeProvider).todos.length - 1]}");

                    await showTodoColorDialog(index: ref.read(homeProvider).todos.length - 1);
                    //ColorSelect cur = ColorSelect(ctx: context, pickedColor: ref.read(homeProvider).pickerColor,);
                    //await cur.showTodoColorDialog(index: ref.read(homeProvider).todos.length - 1);
                    _focusNode.unfocus();
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
                  icon: Icon(Icons.send)
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }
}
