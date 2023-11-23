import 'package:flutter/material.dart';
import 'package:paytriot/pages/create_acc_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paytriot/pages/view_accs_page.dart';
import 'package:paytriot/pages/write_scan_page.dart';

class Home_Page extends StatefulWidget {
  @override
  State<Home_Page> createState() => _HomePage();
}

class _HomePage extends State<Home_Page> {
  final box = GetStorage();

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
                    )),
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
                  box.write('page', 'Create');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateAccPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF00523E),
                  fixedSize: const Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),

              // Scan NFC Card Button
              ElevatedButton(
                child: const Text('Scan NFC Card'),
                onPressed: () {
                  box.write('page', 'Scan');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WriteScan()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF1C1C1C),
                  backgroundColor: Color(0xFFDEDEDE),
                  fixedSize: const Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),

              ElevatedButton(
                child: const Text('View Accounts'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewAccPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color(0xFFDEDEDE),
                  fixedSize: const Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),

              const SizedBox(height: 100),

              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: [
                      //Star Logo
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/star_logo.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),

                      // Powered by...
                      const Text(
                        "Powered by DLSU-D CSCS Students",
                        style: TextStyle(
                            color: Color(0xFF00523E),
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
