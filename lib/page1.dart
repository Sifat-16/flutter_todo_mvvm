import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("   Flutter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
      ),
      body: Column(
        children: [
          Center(child: Text("Hello World!", style: TextStyle(fontSize: 40, color: Colors.green, fontWeight: FontWeight.bold))),
        ],
      ),
    ));
  }
}
