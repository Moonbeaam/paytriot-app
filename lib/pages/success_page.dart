import 'package:flutter/material.dart';
import 'package:paytriot/pages/write_scan_page.dart';

class Success_Page extends StatefulWidget {
  @override
  State<Success_Page> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<Success_Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),

              // Paytriot
              const Text(
                "paytriot",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 30),

              // Transaction Successful!
              const Text(
                "Transaction Successful!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900
                ),
              ),

              const SizedBox(height: 30),

              // Success Icon
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/success.png'),
                    fit: BoxFit.fitWidth,
                  )
                ),
              ),

              const SizedBox(height: 10),

              // Cash In Process
              const Text(
                "Cash-in Processed",
                style: TextStyle(
                  color: Color(0xFF848484),
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "+₱500",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w900
                ),
              ),

              const SizedBox(height: 20),

              // Card Balance
              Container(
                width: 320,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF298871),
                      Color(0xFF00523E)
                    ]
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Logo
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/P.png'),
                              fit: BoxFit.fitWidth,
                            )
                          ),
                        ),
                        const SizedBox(width: 180),
                        // Student Number
                        const Text("202131234",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    const Text("Total Balance",
                      style: TextStyle(
                        color: Colors.white,
                            fontSize: 10,
                      ),
                    ),

                    const SizedBox(height: 2), 
                    
                    const Row(
                      children: [
                        // Money Balance
                        Text("\₱1,500.00",
                        style: TextStyle(
                          color: Colors.white,
                              fontSize: 20,
                        ),),
                        
                        SizedBox(width: 90), 

                        // Student Number
                        Text("Last updated 22 Nov. 2023",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 6,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),

              const SizedBox(height: 30),

              // Cash In Process
              const Text(
                "Thank you for using Paytriot!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w900
                ),
              ),

              const SizedBox(height: 30),

              // Continue Button
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WriteScan()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF00523E),
                  fixedSize: const Size(140, 40)
                ),
              ),

              const SizedBox(height: 30),

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