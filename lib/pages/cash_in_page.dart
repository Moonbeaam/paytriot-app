import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paytriot/pages/success_page.dart';
import './num_pad.dart';

class CashInPage extends StatefulWidget {
  @override
  State<CashInPage> createState() => _CashInPageState();
}

class _CashInPageState extends State<CashInPage> {
  String studNum = '';
  String displayText = '';
  String cashInAmount = '';
  late StudAcc studentAccount;
  final box = GetStorage();
  final TextEditingController _myController = TextEditingController();
 
   void readStudAcc() async {
       try {
      final result = await StudAccDB.instance
          .readAcc(box.read('studNum')); // Use your readAcc function
      setState(() {
        studentAccount = result;
      });
    } catch (e) {
      e.toString();
    }
   }
  @override
  void initState() {
    super.initState();
    readStudAcc();
  }

  void cashIn() async {
    int newBalance = studentAccount.balance + (int.tryParse(cashInAmount) ?? 0);
    StudAccDB.instance.updateBalance(newBalance, studentAccount.studNum);
    setState(() {
      studentAccount = studentAccount.copy(balance: newBalance);
    });
    print('CASH: $cashInAmount BAL:${studentAccount.balance}');
  }


  Widget buildCashIn() => TextField(
        controller: _myController,
         readOnly: true,
         keyboardType: TextInputType.none,
        decoration: const InputDecoration(
          labelText: 'Cash In Amount',
          border: OutlineInputBorder(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),

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

              const SizedBox(height: 100),

              //Text(displayText),

              const SizedBox(height: 20),



              buildCashIn(),
              const SizedBox(height: 16, width: 5),

              NumPad(
                buttonSize: 65,
                buttonColor: Colors.white,
                controller: _myController,
                delete: () {
                  _myController.text = _myController.text.substring(0, _myController.text.length - 1);
                },
                onSubmit: () {
                  cashInAmount = _myController.text;
                  cashIn();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Success_Page()));
                },
              ),
            ],
            
          ),

        )
      ),
    );
  }
}