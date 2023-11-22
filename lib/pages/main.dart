import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:paytriot/pages/home_page.dart';
import 'package:paytriot/pages/menu_page.dart';
=======
>>>>>>> 7f286cec400a6de9f14e3e5e952f7466ed328da7
import 'package:paytriot/pages/sign_up_login_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito Sans'
      ),
      home: Home_Page(),
    );
  }
}