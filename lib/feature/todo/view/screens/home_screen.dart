import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/view/screens/new_todo_add.dart';
import 'package:flutter_todo_mvvm/feature/todo/view/screens/search.dart';
import 'package:flutter_todo_mvvm/feature/todo/view/screens/update_todo.dart';
import 'package:flutter_todo_mvvm/feature/todo/view_model/home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController todoAddController = TextEditingController();

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
              child: const Text('Cancel', style: TextStyle(color: Colors.red),),
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
    }

    print("Chosen color ${chosenColor?.toHexString()}");
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, // Drawer Icon
        ),
        title: Text("Todo Home", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              child: Icon(Icons.search, size: 32, color: Colors.orangeAccent),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                print("Search icon working");
              }
            ),
          )
        ],
      ),
      // body: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      //   child: Column(
      //     children: [
      //       // TextField(
      //       //   controller: todoAddController,
      //       //   maxLines: 4,
      //       //   minLines: 1,
      //       //   focusNode: _focusNode,
      //       //   decoration: InputDecoration(
      //       //       suffixIcon: IconButton(
      //       //           onPressed: () {
      //       //             ref.read(homeProvider.notifier).addTodo(title: todoAddController.text.trim());
      //       //             todoAddController.clear();
      //       //             showTodoColorDialog(index: ref.read(homeProvider).todos.length - 1);
      //       //             _focusNode.unfocus();
      //       //           },
      //       //           icon: Icon(Icons.send)
      //       //       ),
      //       //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      //       //   ),
      //       // ),
      //       Expanded(
      //         child: ListView.builder(
      //             itemCount: home.todos.length,
      //             itemBuilder: (context, index) {
      //               return ListTile(
      //                 leading: Checkbox(
      //                     value: home.todos[index].isSelected,
      //                     onChanged: (b) {
      //                       ref.read(homeProvider.notifier).toggleSelected(selected: b ?? false, index: index);
      //                     }
      //                 ),
      //                 title: Text("${home.todos[index].title}",
      //                   style: TextStyle(
      //                       color: home.todos[index].hexColor == null
      //                           ? null : Color(colorExtractor(colorString: home.todos[index].hexColor ?? ""))
      //                   ),
      //                 ),
      //                 trailing: Row(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     IconButton(
      //                         onPressed: () async {
      //                           showTodoColorDialog(index: index);
      //                         },
      //                         icon: Icon(Icons.color_lens_sharp)
      //                     ),
      //                     IconButton(
      //                         onPressed: (){
      //                           // Navigate to the "Add New Item" screen
      //                           Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTodo(currentIndex: index)),);
      //                         },
      //                       icon: Icon(Icons.edit_note_outlined, size: 35),
      //                     ),
      //                     IconButton(
      //                         onPressed: () {
      //                           ref.read(homeProvider.notifier).deleteTodo(index: index);
      //                         },
      //                         icon: Icon(Icons.delete)
      //                     ),
      //                   ],
      //                 ),
      //               );
      //             }),
      //       )
      //     ],
      //   ),
      // ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.person, size: 120,),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              for(var i = 0; i < 20; i++)
              ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.ac_unit
                  ),
                ),
                title: Text("Rayhan Chowdhury"),
                subtitle: Text("Software Engineer"),
                trailing: Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Divider(color: Colors.orange),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: home.todos.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        // Navigate to the "Add New Item" screen
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTodo(currentIndex: index)),);
                        print("Container Working");
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                    maxLines: 5,
                                    '${home.todos[index].title}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: home.todos[index].hexColor == null? null : Color(colorExtractor(colorString: home.todos[index].hexColor?? "")), fontSize: 20)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        showTodoColorDialog(index: index);
                                        print("Color Icon working");
                                      },
                                      child: Icon(Icons.color_lens, color: Colors.orange, size: 28)
                                  ),
                                  GestureDetector(
                                      onTap: (){
                                        ref.read(homeProvider.notifier).deleteTodo(index: index);
                                      },
                                      child: Icon(Icons.delete, color: Colors.orange, size: 28,)
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the "Add New Item" screen
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewTodoAdd()),);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
