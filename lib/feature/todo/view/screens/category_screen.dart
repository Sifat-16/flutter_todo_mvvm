import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_mvvm/feature/todo/view_model/home_view_model.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  TextEditingController categoryAddController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((t) {
      ref.read(categoryProvider.notifier).getCategory();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(categoryProvider);

    return  Scaffold(
      appBar: AppBar(
        title: Text("Category Screen"),


      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Column(
          children: [
            TextField(
              controller: categoryAddController,
              maxLines: 4,
              minLines: 1,
              decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    ref.read(categoryProvider.notifier).addCategory(title: categoryAddController.text.trim());
                    categoryAddController.clear();
                  },

                      icon: Icon(Icons.send)
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: home.categories.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(

                        title: Text(
                          "${home.categories[index].title}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                },

                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
