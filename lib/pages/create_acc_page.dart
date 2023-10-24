import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';

class CreateAccPage extends StatefulWidget {
  @override

  State<CreateAccPage> createState() => _CreateAccPageState();
}

class _CreateAccPageState extends State<CreateAccPage> {
  String studNum = '';
  String lastName = '';
  String firstName = '';
  String middleName = '';

  void addStudAcc() async {

    final studAcc = StudAcc(
      studNum: studNum,
      lastName: lastName,
      firstName: firstName,
      middleName: middleName,
      balance:  0,
    );
    StudAccDB.instance.create(studAcc);
  }

  Widget buildStudNum() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'StudentNumber',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) => setState(() => studNum = value),
      );
  Widget buildLastName() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Last Name',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) => setState(() => lastName = value),
      );
  Widget buildFirstName() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'First Name',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) => setState(() => firstName = value),
      );
  Widget buildMiddleName() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Middle Name',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) => setState(() => middleName = value),
      );
  Widget button() => TextButton(
        onPressed: addStudAcc,
        child: const Text(
          'Create',
        ),
      );
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),
      body: ListView(
        children: [
          buildStudNum(),
          const SizedBox(height: 16, width: 5),
          buildLastName(),
          const SizedBox(height: 16),
          buildFirstName(),
          const SizedBox(height: 16),
          buildMiddleName(),
          const SizedBox(height: 16),
          button(),
        ],
      ),
    );
  }
}
