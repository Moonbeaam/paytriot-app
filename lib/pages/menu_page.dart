import 'package:flutter/material.dart';
import 'package:paytriot/pages/create_acc_page.dart';
import 'package:paytriot/pages/read_id_page.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MenuPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key, required this.title});

  final String title;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  Widget buttToCreateAcc() => TextButton(
    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccPage()));
    },
    child: const Text(
      'Create Account',
    ),
  );

  Widget buttToReadID() => TextButton(
    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadIdPage()));
    },
    child: const Text(
      'Add Balance',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: ListView(
        children:[
          buttToCreateAcc(),
          buttToReadID()
        ]
      ),
    );
  }
}
