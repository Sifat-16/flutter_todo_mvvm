import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadTodoTItle extends ConsumerStatefulWidget {
  final String title;
  final Color color;
  const ReadTodoTItle({super.key, required this.title, required this.color});

  @override
  ConsumerState<ReadTodoTItle> createState() => _ReadTodoTItleState();
}

class _ReadTodoTItleState extends ConsumerState<ReadTodoTItle> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){print(widget.color);
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios_new, color: Colors.orange, size: 28,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(widget.title, style: TextStyle(fontSize: 22, color:  widget.color)),
      ),
    );
  }
}
