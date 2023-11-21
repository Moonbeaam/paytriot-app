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
              const SizedBox(height: 50),

              // Welcome to
              Text(
                "Welcome to",
                style: TextStyle(),)

              // Logo

              // Paytriot

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