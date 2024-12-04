import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/category_view_model/category_view_model.dart';
import 'package:flutter_todo_mvvm/feature/todo/view/category_screen/add_categories.dart';

class HomeCategory extends ConsumerStatefulWidget {
  const HomeCategory({super.key});

  @override
  ConsumerState<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends ConsumerState<HomeCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(categoryProvider.notifier).todoInitialize();
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(categoryProvider);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios_new, size: 25, color: Colors.orange,)
        ),
        title: Text("Category", style: TextStyle(color: Colors.orange, fontSize: 30, fontWeight: FontWeight.w600),),
      ),
      body: Column(
        children: [
          Divider(color: Colors.orange),
          Expanded(
            child: ListView.builder(
                itemCount: home.categoryTodo.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: ListTile(
                      title: Text("${home.categoryTodo[index].title}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: (){
                              // Navigate to the "Add New Item" screen
                              //.push(context, MaterialPageRoute(builder: (context) => UpdateTodo(currentIndex: index)),);
                            },
                            icon: Icon(Icons.edit_note_outlined, size: 35),
                          ),
                          IconButton(
                              onPressed: () {
                                ref.read(categoryProvider.notifier).deleteTodo(index: index);
                              },
                              icon: Icon(Icons.delete)
                          ),
                        ],
                      ),
                    ),
                    children: [
                      ListTile(
                        title: Text("${home.categoryTodo[index].importance}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Divider(color: Colors.green),
                      ListTile(
                        title: Text("${home.categoryTodo[index].description}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ]

                  );
                }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the "Add New Item" screen
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategories()),);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
