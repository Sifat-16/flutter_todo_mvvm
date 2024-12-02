import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/model/todo_model.dart';
import 'package:flutter_todo_mvvm/feature/todo/view/screens/readTodoTitle.dart';
import 'package:flutter_todo_mvvm/feature/todo/view/screens/update_todo.dart';

import '../../view_model/home_view_model.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  List<TodoModel> searchedWord = [];
  @override
  @override
  void initState() {
    super.initState();
    // Initialize the filteredTodos with all the todos from the provider
    searchedWord = ref.read(homeProvider).todos;
  }

  TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  void _clearSearch() {
    setState(() {
      searchedWord = ref.watch(homeProvider).todos;
      _controller.clear();
      _isSearching = false; // Reset search state when the text is cleared
      FocusScope.of(context).unfocus();
    });
  }


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
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios_new, color: Colors.orange,)
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: TextField(
            controller: _controller,
            onChanged: (text) {
              setState(() {
                _isSearching = text.isNotEmpty; // Show cancel icon when there's text

                searchedWord = ref.watch(homeProvider).todos.where((tmp)=>tmp.title.toLowerCase().startsWith(text.toLowerCase())).toList();
              });
            },
            decoration: InputDecoration(
              // Background Color
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search...', // Hint text inside the search bar
              prefixIcon: Icon(Icons.search), // Search icon
              suffixIcon: _isSearching ? IconButton(icon: Icon(Icons.clear), onPressed: _clearSearch) : null, // Only show cancel icon if there's text
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
          ),
        ),
      ),
      body: searchedWord == null || searchedWord!.isEmpty ? Center(child: Text('No results found', style: TextStyle(fontSize: 18))) // Show "No results" when no search or no matches
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: searchedWord.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    // Navigate to the "Add New Item" screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReadTodoTItle(title: searchedWord![index].title, color: Color(colorExtractor(colorString: searchedWord![index].hexColor??"ff443a49"),))));
                    print("Container Working");
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                              maxLines: 5,
                              '${searchedWord![index].title}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: searchedWord![index].hexColor == null? null : Color(colorExtractor(colorString: searchedWord[index].hexColor?? "")), fontSize: 20)
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
          ),
        ),

      // : ListView.builder(
      //   itemCount: searchedWord!.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Column(
      //       children: [
      //         Container(
      //           height: 20,
      //           width: 80,
      //           color: Colors.yellowAccent,
      //           child: Center(child: Text(searchedWord![index].title, style: TextStyle(fontSize: 16),)),
      //         ),
      //         SizedBox(height: 10),
      //       ],
      //     );
      //   },
      // )
    );
  }
}
