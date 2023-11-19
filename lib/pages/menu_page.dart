import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paytriot/pages/create_acc_page.dart';
import 'package:paytriot/pages/read_id_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paytriot/pages/view_accs.dart';

Future main() async {
  await dotenv.load(fileName: "lib/Algorithms/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF007229)),
        useMaterial3: true,
      ),
      home: const MenuPage(title: 'Flutter Demo Home Page'),
    );
  }
}
class ButtonStyleNotifier extends ChangeNotifier {
  bool isCreateAccButtonPressed = false;

  void toggleCreateAccButton() {
    isCreateAccButtonPressed = !isCreateAccButtonPressed;
    notifyListeners();
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
  bool isCreateAccButtonPressed = false;

  void getAction(String action) async {
    await GetStorage.init();
    box.write('action', action).toString();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReadIdPage()));
  }

  Widget buttToCreateAcc() => OutlinedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateAccPage()));
        },
        child: const Text(
          'Create Account',
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor:
                Colors.white,
          foregroundColor:
                Color(0xFF007229),
        ),
      );

  Widget buttToCashIn() => OutlinedButton(
        onPressed: () {
          getAction('CashIn');
        },
        child: const Text(
          'Cash In',
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor:
              Colors.white,
          foregroundColor:
              Color(0xFF007229),
        ),
      );

  Widget buttToPurchase() => OutlinedButton(
        onPressed: () {
          getAction('Purchase');
        },
        child: const Text(
          'Purchase',
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor:
              Colors.white,
          foregroundColor:
              Color(0xFF007229),
        ),
      );
  Widget buttToViewAcc() => OutlinedButton(
    onPressed: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ViewAccPage()));
    },
    child: const Text(
      'View Accounts',
    ),
    style: OutlinedButton.styleFrom(
      backgroundColor:
      Colors.white,
      foregroundColor:
      Color(0xFF007229),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(children: [
        buttToCreateAcc(),
        buttToCashIn(),
        buttToPurchase(),
        buttToViewAcc(),
      ]),
    );
  }
}
