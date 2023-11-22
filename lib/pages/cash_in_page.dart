import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:get_storage/get_storage.dart';

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

  void readStudAcc() async {
    try {
      final result = await StudAccDB.instance
          .readAcc(box.read('studNum')); // Use your readAcc function
      setState(() {
        studentAccount = result;
        displayText =
            "Name: ${studentAccount.firstName} ${studentAccount.middleName} "
            "${studentAccount.lastName}\n"
            "Student Number: ${studentAccount.studNum}\n"
            "Balance: ${studentAccount.balance}";
      });
    } catch (e) {
      displayText = e.toString();
    }
  }

  void cashIn() async {
    int newBalance = studentAccount.balance + (int.tryParse(cashInAmount) ?? 0);
    StudAccDB.instance.updateBalance(newBalance, studentAccount.studNum);
    studentAccount = studentAccount.copy(balance: newBalance);

    setState(() {
      displayText =
          "Name: ${studentAccount.firstName} ${studentAccount.middleName} "
          "${studentAccount.lastName}\n"
          "Student Number: ${studentAccount.studNum}\n"
          "Balance: ${studentAccount.balance}";
    });
  }

  Widget buildCashIn() => TextField(
        decoration: const InputDecoration(
          labelText: 'Cash In Amount',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) => setState(() => cashInAmount = value),
      );

  Widget btnCashIn() => TextButton(
        onPressed: cashIn,
        child: const Text(
          'Cash In',
        ),
      );

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

              // Tap NFC Icon
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/nfc_tap.png'),
                    fit: BoxFit.fitWidth,
                  )
                ),
              ),

              const SizedBox(height: 20),

              // Tap Text
              const Text(
                "Tap your NFC card to continue",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w800
                ),
              ),

              buildCashIn(),
              const SizedBox(height: 16, width: 5),
              btnCashIn()
            ],
          )
        )
      ),
    );
  }
}
