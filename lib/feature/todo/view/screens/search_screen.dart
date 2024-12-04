import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/view_model/home_view_model.dart';


class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {

  TextEditingController todoAddController = TextEditingController();
  Color? chosenColor;

  void showTodoColorDialog({required int index}) async {


    // raise the [showDialog] widget
    await showDialog(
      context: context,
      barrierDismissible: false,
      ///ds wedwed
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
          actions: <Widget>[ //ghghffff
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
      ref.read(homeProvider.notifier).updatetodo(hexColor: chosenColor!.toHexString(), index: index,);
    }

    print("Chosen color ${chosenColor?.toHexString()}");
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
      ),

      body: Column(
        children: [
          TextField(
            controller: todoAddController,
            maxLines: 4,
            minLines: 1,
            decoration: InputDecoration(
              /// ======================
              suffixIcon: IconButton(
                onPressed: () {
                  showTodoColorDialog(
                      index: ref.read(homeProvider).todos.length );

                  ref.read(homeProvider.notifier).addTodo(title: todoAddController.text.trim(),hexcolor: chosenColor!.toHexString());
                  todoAddController.clear();

                },
                icon: Icon(Icons.send),
              ),

              /// ==============================
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
