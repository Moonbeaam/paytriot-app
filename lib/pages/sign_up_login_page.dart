import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Sign_Up_Login_Page extends StatelessWidget {
  const Sign_Up_Login_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 280),

              // Welcome to
              Text(
                "Welcome to",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),

              // Logo


              // Paytriot
              Text(
                "paytriot",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 36,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),

              // Create Account Button

              // Scan NFC Card Button

              // Star Logo

              // Powered by...
            ],
          ),
        ),
      )
    );
  }
}