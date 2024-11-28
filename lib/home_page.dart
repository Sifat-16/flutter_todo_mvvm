import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _State();
}

class _State extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          for (int i = 1; i <= 8; i++)
            Row(
              children: [
                for (int j = 1; j <= 8; j++)
                  Container(
                    height: MediaQuery.of(context).size.width / 8,
                    width: MediaQuery.of(context).size.width / 8,
                    color: (i & 1 == 1)
                        ? ((j & 1 == 1) ? Colors.black : Colors.white)
                        : ((j & 1 == 0) ? Colors.black : Colors.white),
                  )
              ],
            ),
          
          GestureDetector(
            child: Container(
              height: 60,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text("Exit", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }
}
