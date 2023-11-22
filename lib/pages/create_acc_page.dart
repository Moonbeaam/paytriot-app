
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:paytriot/pages/menu_page.dart';
import 'package:paytriot/pages/sign_up_login_page.dart';
import 'package:paytriot/pages/log_in_page.dart';
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
        decoration: InputDecoration(
          labelText: 'Student Number',
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "201234567",
          fillColor: Colors.white70,
          constraints: BoxConstraints(maxHeight:56,maxWidth: 300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                width: 20, 
                style: BorderStyle.none,
            ),
          ),
        ),
        onChanged: (value) => setState(() => studNum = value),
      ); 

  Widget buildLastName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Last Name',
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "e.g. Salazar",
          fillColor: Colors.white70,
          constraints: BoxConstraints(maxHeight:56,maxWidth: 300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                width: 20, 
                style: BorderStyle.none,
            ),
          ),
        ),
        onChanged: (value) => setState(() => lastName = value),
      );
  Widget buildFirstName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'First Name',
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "e.g. Apollo Zeus",
          fillColor: Colors.white70,
          constraints: BoxConstraints(maxHeight:56,maxWidth: 300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                width: 20, 
                style: BorderStyle.none,
              ),
          ),
        ),
        onChanged: (value) => setState(() => firstName = value),
      );
  Widget buildMiddleName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Middle Name',
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "e.g. Verano",
          fillColor: Colors.white70,
          constraints: BoxConstraints(maxHeight:56,maxWidth: 300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                width: 20, 
                style: BorderStyle.none,
              ),
          ),
        ),
        onChanged: (value) => setState(() => middleName = value),
      );
  Widget button() => ElevatedButton(
        child: const Text(
          'Create',
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF00523E),
          fixedSize: const Size(300,40)
        ),
        onPressed: () {
          addStudAcc();
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
              Text(
                "Welcome to",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              // Logo
              // Paytriot
              Text(
                "paytriot",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 36,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
          const SizedBox(height: 32),
          const SizedBox(height: 16, width: 250),
          buildStudNum(),
          const SizedBox(height: 16, width: 250),
          buildLastName(),
          const SizedBox(height: 16, width: 250),
          buildFirstName(),
          const SizedBox(height: 16, width: 250),
          buildMiddleName(),
          const SizedBox(height: 16, width: 250),
          const SizedBox(height: 26),
          button(),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?", style: TextStyle(
              color: Color(0xFF9C9C9C)
              )
            ),

            TextButton(
              onPressed: ()
                {Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Page()));
            },
            child: const Text("Login"),
              style: TextButton.styleFrom(
              foregroundColor: Color(0xFF00523E)
                   ),
                  ),
                ],
              ),      
            // Star Logo
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/star_logo.png'),
                    fit: BoxFit.fitWidth,
                  )
                ),
              ),
            // Powered by...
            const Text(
                "Powered by DLSU-D CSCS Students",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600
                ),
          )
        ],
               ),
          ),
        ),
      );
  }
}
