import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paytriot/pages/cash_in_page.dart';
import 'package:paytriot/pages/create_acc_page.dart';
import 'package:paytriot/pages/purchase_page.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

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

              const SizedBox(height: 60),

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
                              image: AssetImage('assets/images/P only.png'),
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
                        Text("\₱1,000.00",
                        style: TextStyle(
                          color: Colors.white,
                              fontSize: 20,
                        ),),
                        
                        SizedBox(width: 90), 

                        // Student Number
                        Text("Last updated 20 Nov. 2023",
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

              const SizedBox(height: 40),

              // Cash In
              OutlinedButton(
                child: const Text('Cash In',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:  FontWeight.w900
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CashInPage()));
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF00523E),
                  fixedSize: const Size(320, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)
                  ),
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xFF00523E))
                ),
              ),

              const SizedBox(height: 20),

              // Purchase
              OutlinedButton(
                child: const Text('Purchase',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:  FontWeight.w900
                  ),),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PurchasePage()));
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF00523E),
                  fixedSize: const Size(320, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)
                  ),
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xFF00523E))
                ),
              ),

              const SizedBox(height: 180),

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