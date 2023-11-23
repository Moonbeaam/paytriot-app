import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';

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
      appBar: AppBar(
        title: Text('Student Account Table'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
    );
  }
}
