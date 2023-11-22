import 'package:flutter/material.dart';
import 'package:paytriot/pages/home_page.dart';
import 'package:paytriot/pages/menu_page.dart';
import 'package:paytriot/pages/sign_up_login_page.dart';
import 'package:paytriot/pages/success_page.dart';



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
      routes: {

      },
      home: Sign_Up_Login_Page(),
    );
  }
}