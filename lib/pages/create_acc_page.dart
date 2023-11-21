
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:paytriot/pages/menu_page.dart';
import '../NFC/NFC.dart';
import '../NFC/encrypt.dart';
import '../Algorithms/huffman.dart' as hm;
import '../Algorithms/AES.dart';
class CreateAccPage extends StatefulWidget {
  @override
  State<CreateAccPage> createState() => _CreateAccPageState();
}


class _CreateAccPageState extends State<CreateAccPage> {
  String studNum = '';
  String lastName = '';
  String firstName = '';
  String middleName = '';
  hm.Huffman huffman= hm.Huffman();

  void writeNFC() async{
    NFCData nfcData = NFCData(ID: studNum,FirstName: firstName);
    String encodedData = encodeNFCData(nfcData); 
    String encryptedData= encryptAES(encodedData);
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        Ndef? ndef = Ndef.from(tag);
        if (ndef != null && ndef.isWritable) {
          List<NdefRecord> records = [
            NdefRecord.createMime(
              'application/json',Uint8List.fromList(utf8.encode(encryptedData)),
            ),
          ];
          NdefMessage ndefMessage = NdefMessage(records);

          await ndef?.write(ndefMessage);
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
        }
      },
    );
  }

  void addStudAcc() async {
    final studAcc = StudAcc(
      studNum: studNum,
      lastName: lastName,
      firstName: huffman.encode(firstName),
      middleName: middleName,
      balance: 0,
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
        child: const Text(
          'Create',
        ),
        onPressed: () {
          addStudAcc();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Tap Card to Write '),
              )
          );
          writeNFC();
        },
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      body: SafeArea(
        child: Center(
          child: Column(
              children:[
                const SizedBox(height: 40),
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
      ),
      )
    );
  }
}
