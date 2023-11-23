import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:paytriot/pages/home_page.dart';

import 'transaction_page.dart';

final ScrollController _horizontal = ScrollController(),
    _vertical = ScrollController();

class ViewAccPage extends StatefulWidget {
  @override
  _ViewAccPageState createState() => _ViewAccPageState();
}

class _ViewAccPageState extends State<ViewAccPage> {
  List<StudAcc> studentAccounts = [];

  @override
  void initState() {
    super.initState();
    loadStudentAccounts();
  }

  Future<void> loadStudentAccounts() async {
    final List<StudAcc> accounts = await StudAccDB.instance.getAllAccounts();

    // Sorting the accounts using merge sort
    List<StudAcc> sortedAccounts = mergeSort(accounts);

    setState(() {
      studentAccounts = sortedAccounts; // Corrected assignment here
    });
  }

  List<StudAcc> mergeSort(List<StudAcc> list) {
    if (list.length <= 1) {
      return list;
    }

    final int mid = (list.length / 2).floor();
    final List<StudAcc> left = mergeSort(list.sublist(0, mid));
    final List<StudAcc> right = mergeSort(list.sublist(mid));

    return merge(left, right);
  }

  List<StudAcc> merge(List<StudAcc> left, List<StudAcc> right) {
    List<StudAcc> result = [];
    int leftIndex = 0, rightIndex = 0;

    while (leftIndex < left.length && rightIndex < right.length) {
      if (left[leftIndex].studNum.compareTo(right[rightIndex].studNum) <= 0) {
        result.add(left[leftIndex]);
        leftIndex++;
      } else {
        result.add(right[rightIndex]);
        rightIndex++;
      }
    }

    // Add the remaining elements
    result.addAll(left.sublist(leftIndex));
    result.addAll(right.sublist(rightIndex));

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Sign_Up_Login_Page()));
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
                  'Accounts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _vertical, // Use the vertical controller here
              scrollDirection: Axis.vertical,
              child: Scrollbar(
                controller: _horizontal, // Use the horizontal controller here
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: _horizontal, // Use the horizontal controller here
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Student Number'),
                      ),
                      DataColumn(
                        label: Text('Balance'),
                      ),
                    ],
                    rows: studentAccounts
                        .map(
                          (account) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(account.studNum)),
                              DataCell(Text(account.balance.toString())),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
