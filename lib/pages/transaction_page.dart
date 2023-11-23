import 'package:flutter/material.dart';
import 'package:paytriot/pages/cash_in_page.dart';
import 'package:paytriot/pages/purchase_page.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:get_storage/get_storage.dart';
class Transaction_Page extends StatefulWidget {
  @override
  State<Transaction_Page> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<Transaction_Page> {
    late StudAcc studentAccount= const StudAcc(studNum: '', lastName: '', firstName: '', middleName: '', balance: 0);
    final box = GetStorage();

   void readStudAcc() async {
    try {
      final result = await StudAccDB.instance.readAcc(box.read('studNum'));
      if (result != null) {
        setState(() {
          studentAccount = result;
        });
      } else {
        // Handle the case when the result is null
        // For example, you might want to set a default value or show an error message.
      }
    } catch (e) {
      print(e.toString());
      // Handle the error, for example, show an error message.
    }
  }

  @override
    void initState() {
      super.initState();
      readStudAcc();
    }

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
                              image: AssetImage('assets/images/P_white.png'),
                              fit: BoxFit.fitWidth,
                            )
                          ),
                        ),
                        const SizedBox(width: 180),
                        // Student Number
                        Text(studentAccount.studNum,
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
                    
                    Row(
                      children: [
                        // Money Balance
                        Text("${studentAccount.balance}",
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CashInPage()));
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PurchasePage()));
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