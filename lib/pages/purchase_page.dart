import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:get_storage/get_storage.dart';

class PurchasePage extends StatefulWidget {
  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  String studNum = '';
  String displayText = '';
  String errorMsg = '';
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
      displayText = "not found";
    }
  }

  void purchase() async {
    if (int.tryParse(cashInAmount)! <= studentAccount.balance) {
      setState(() {
        errorMsg = "";
      });
      int newBalance =
          studentAccount.balance - (int.tryParse(cashInAmount) ?? 0);
      StudAccDB.instance.updateBalance(newBalance, studentAccount.studNum);
      studentAccount = studentAccount.copy(balance: newBalance);
    } else if (int.tryParse(cashInAmount)! > studentAccount.balance) {
      setState(() {
        errorMsg = "Insufficient Balance";
      });
    }

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
        onPressed: purchase,
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          Text("$displayText"),
          buildCashIn(),
          const SizedBox(height: 16, width: 5),
          btnCashIn(),
          Text("$errorMsg"),
        ],
      ),
    );
  }
}
