import 'package:flutter/material.dart';
import 'package:paytriot/pages/create_acc_page.dart';
import 'package:paytriot/pages/read_id_page.dart';
import 'package:get_storage/get_storage.dart';
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
  final box = GetStorage();

  void getAction(String action) async {
    await GetStorage.init();
    box.write('action', action).toString();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadIdPage()));
  }

  Widget buttToCreateAcc() => TextButton(
    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccPage()));
    },
    child: const Text(
      'Create Account',
    ),
  );

  Widget buttToCashIn() => TextButton(
    onPressed: (){
      getAction('CashIn');
    },
    child: const Text(
      'Cash In',
    ),
  );

  Widget buttToPurchase() => TextButton(
    onPressed: (){
      getAction('Purchase');
    },
    child: const Text(
      'Purchase',
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
          buttToCashIn(),
          buttToPurchase(),
        ]
      ),
    );
  }
}
