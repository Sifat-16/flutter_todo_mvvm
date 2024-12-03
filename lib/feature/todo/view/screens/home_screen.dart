import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/view/screens/search_screen.dart';
import 'package:flutter_todo_mvvm/feature/todo/view_model/home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
 // TextEditingController todoAddController = TextEditingController();

  int colorExtractor({required String colorString}) {
    return int.parse(colorString, radix: 16);
  }

  void showTodoColorDialog({required int index}) async {
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
      ref
          .read(homeProvider.notifier)
          .updateColor(hexColor: chosenColor!.toHexString(), index: index);
    }

    print("Chosen color ${chosenColor?.toHexString()}");
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Home"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Column(
          children: [
            // TextField(
            //   controller: todoAddController,
            //   maxLines: 4,
            //   minLines: 1,
            //   decoration: InputDecoration(
            //     /// ================================================================================
            //     suffixIcon: IconButton(
            //       onPressed: () {
            //         ref
            //             .read(homeProvider.notifier)
            //             .addTodo(title: todoAddController.text.trim());
            //         todoAddController.clear();
            //         showTodoColorDialog(
            //             index: ref.read(homeProvider).todos.length - 1);
            //       },
            //       icon: Icon(Icons.send),
            //     ),
            //
            //     /// ===================================================================================
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  itemCount: home.todos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Checkbox(
                          value: home.todos[index].isSelected,
                          onChanged: (b) {
                            ref.read(homeProvider.notifier).toggleSelected(
                                selected: b ?? false, index: index);
                          }),
                      title: Text(
                        "${home.todos[index].title}",
                        style: TextStyle(
                            color: home.todos[index].hexColor == null
                                ? null
                                : Color(colorExtractor(
                                    colorString:
                                        home.todos[index].hexColor ?? ""))),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                //  showTodoColorDialog(index: index);
                              },
                              icon: Icon(Icons.color_lens_sharp)),
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(homeProvider.notifier)
                                    .deleteTodo(index: index);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
