import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paytriot/pages/sign_up_login_page.dart';
import 'package:paytriot/pages/create_acc_page.dart';

class Login_Page extends StatelessWidget {
  const Login_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),

              // Welcome back to
              const Text(
                "Welcome back to",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800
                ),
              ),

              // Paytriot
              const Text(
                "paytriot",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 32,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 100),

              // Tap NFC Icon

              // 

              // Enable NFC Scan
              ElevatedButton(
                child: const Text('Enable NFC Scan'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF00523E),
                  fixedSize: const Size(300, 40)
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Don't Have an Account
                  const Text(
                    "Don't have an account yet?",
                    style: TextStyle(
                      color: Color(0xFF9C9C9C),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600
                    ),
                  ),

                  // Create Account Button
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccPage()));
                    },
                    child: const Text('Create an Account'),
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF00523E)
                    ),
                  )
                ],
              ),

              const SizedBox(height: 100),

              // Star Logo
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
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
                )
              )
            ]
          )
        )
      )
    );
  }
}