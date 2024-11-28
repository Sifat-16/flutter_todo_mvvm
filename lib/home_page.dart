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
            ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {

                        text_ = "Welcome";

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 50,
                        color: Colors.blue,
                        child: Center(
                          child: Text("Start",
                          style: TextStyle(
                            fontSize: 20,
                          )
                            ,),
                        ),
                      ),
                    ),
                  )

              ),
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {

                        text_ = "Welcome";

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 50,
                        color: Colors.red,
                        child: Center(
                          child: Text("",
                            style: TextStyle(
                              fontSize: 20,
                            )
                            ,),
                        ),
                      ),
                    ),
                  )

              ),
            ],
          ),

          SizedBox(height: 20,),
          Text(text_
          ,style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
