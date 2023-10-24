import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paytriot/pages/cash_in_page.dart';

class ReadIdPage extends StatefulWidget {
  @override

  State<ReadIdPage> createState() => _ReadIdPageState();
}

class _ReadIdPageState extends State<ReadIdPage> {
  String studNum = '';
  String displayText='';
  String balText='';
  late StudAcc studentAccount;
  final box = GetStorage();

  void getStudAcc() async {
    try {
        final result = await StudAccDB.instance.readAcc(box.read('studNum')); // Use your readAcc function
        if(result!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CashInPage()));
        }
        else{
          setState(() {
            displayText = "asdasd";
          });
        }

    } catch (e) {
      setState(() {
        displayText = Exception(e).toString();
      });
    }
  }
  void getStudNum() async {
    await GetStorage.init();
    box.write('studNum', studNum).toString();
    getStudAcc();
  }

  Widget buildStudNum() => TextFormField(
    decoration: const InputDecoration(
      labelText: 'StudentNumber',
      border: OutlineInputBorder(),
    ),
    onChanged: (value) => setState(() => studNum = value),
  );

  Widget button() => TextButton(
    onPressed: getStudNum,
    child: const Text(
      'Search',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          buildStudNum(),
          const SizedBox(height: 16, width: 5),
          button(),
          Text(
              displayText
          )
        ],
      ),
    );
  }
}
