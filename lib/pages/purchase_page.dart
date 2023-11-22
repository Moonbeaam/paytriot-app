import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:paytriot/DB/transaction_db.dart';
import 'package:paytriot/model/transaction.dart' as trans;
import 'package:get_storage/get_storage.dart';
import '../Algorithms/huffman.dart' as hm;

class PurchasePage extends StatefulWidget {
  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  String studNum = '';
  String displayText = '';
  String errorMsg = '';
  String purchaseAmount = '';
  late StudAcc studentAccount;
  final box = GetStorage();
  hm.Huffman huffman= hm.Huffman();
  
  void readStudAcc() async {
    try {
      final result = await StudAccDB.instance
          .readAcc(box.read('studNum')); // Use your readAcc function
      setState(() {
        studentAccount = result;
        displayText =
            "Name: ${huffman.decode(studentAccount.firstName, box.read('firstName'))} ${studentAccount.middleName} "
            "${studentAccount.lastName}\n"
            "Student Number: ${studentAccount.studNum}\n"
            "Balance: ${studentAccount.balance}";
      });
    } catch (e) {
      displayText = e.toString();
    }
  }

  void purchase() async {
    if (int.tryParse(purchaseAmount)! <= studentAccount.balance) {
      setState(() {
        errorMsg = "";
      });
      int newBalance =
          studentAccount.balance - (int.tryParse(purchaseAmount) ?? 0);
      StudAccDB.instance.updateBalance(newBalance, studentAccount.studNum);
      studentAccount = studentAccount.copy(balance: newBalance);
    } else if (int.tryParse(purchaseAmount)! > studentAccount.balance) {
      setState(() {
        errorMsg = "Insufficient Balance";
      });
    }

    final transact = trans.Transaction(
      amount: int.tryParse(purchaseAmount)!,
      date: "Friday",
    );
    TransactionDB.instance.insert(transact);

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
        onChanged: (value) => setState(() => purchaseAmount = value),
      );

  Widget btnPurchase() => TextButton(
        onPressed: purchase,
        child: const Text(
          'Purchase',
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
          Text(displayText),
          buildCashIn(),
          const SizedBox(height: 16, width: 5),
          btnPurchase(),
          Text(errorMsg),
        ],
      ),
    );
  }
}
