import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(


        //gfgfgfg

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),

      ),

      body: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
          ),
          child: Column(
           children: [
             for(int i = 1;i<=8;i++)
               Row(
                 children: [
                   for(int j = 1;j<=8;j++)
                     Container(
                       height: MediaQuery.of(context).size.width/10,
                       width: MediaQuery.of(context).size.width/10,
                         color: (i&1==1)? ((j&1 ==1)? Colors.black:Colors.white)  : ((j&1 ==0)? Colors.black:Colors.white) ,
                     )
                 ],
               )
           ],
          ),
        ),
      ),

    );
  }
}
