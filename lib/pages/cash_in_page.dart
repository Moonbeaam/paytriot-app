import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paytriot/pages/transaction_page.dart';
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
        decoration: InputDecoration(
          labelText: 'PHP',
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "Input Amount",
          fillColor: Colors.white70,
          constraints: BoxConstraints(maxHeight: 56, maxWidth: 300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              width: 20,
              style: BorderStyle.none,
            ),
          ),
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
            AppBar(
              title: Text(
                "paytriot",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const BackButtonIcon(),
                color: Color(0xFF00523E),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Transaction_Page()));
                },
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 60,
              color: Color(0xFF00523E),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 18),
                  Text(
                    'Cash In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),

            //Text(displayText),

            const SizedBox(height: 70),

            buildCashIn(),
            const SizedBox(height: 16, width: 5),

            NumPad(
              buttonSize: 65,
              buttonColor: Colors.white,
              controller: _myController,
              delete: () {
                _myController.text = _myController.text
                    .substring(0, _myController.text.length - 1);
              },
              onSubmit: () {
                cashInAmount = _myController.text;
                cashIn();
                box.write('amount', cashInAmount);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Success_Page()));
              },
            ),

            const SizedBox(height: 60), // NumPad and Star Logo Divider

            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/star_logo.png'),
                fit: BoxFit.fitWidth,
              )),
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
      )),
    );
  }
}
