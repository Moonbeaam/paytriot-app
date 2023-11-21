import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paytriot/pages/create_acc_page.dart';
import 'package:paytriot/pages/log_in_page.dart';

class Sign_Up_Login_Page extends StatelessWidget {
  const Sign_Up_Login_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 240),

              // Welcome to
              const Text(
                "Welcome to",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/P.png'),
                        fit: BoxFit.fitWidth,
                      )
                    ),
                  ),

                  SizedBox(width: 3),
                  
                  // Paytriot
                  const Text(
                    "paytriot",
                    style: TextStyle(
                      color: Color(0xFF00523E),
                      fontSize: 40,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 100),

              // Create Account Button
              ElevatedButton(
                child: const Text('Create an Account'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF00523E),
                  fixedSize: const Size(300, 40)
                ),
              ),

              // Scan NFC Card Button
              ElevatedButton(
                child: const Text('Scan NFC Card'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Page()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF1C1C1C),
                  backgroundColor: Color(0xFFDEDEDE),
                  fixedSize: const Size(300, 40)
                ),
              ),

              const SizedBox(height: 100),

              // Star Logo
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/star_logo.png'),
                    fit: BoxFit.fitWidth,
                  )
                ),
              ),

              // Powered by...
              const Text(
                "Powered by DLSU-D CSCS Students",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}