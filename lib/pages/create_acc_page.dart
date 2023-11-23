import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:paytriot/pages/home_page.dart';
import 'package:paytriot/pages/write_scan_page.dart';
import '../NFC/NFC.dart';
import '../Algorithms/huffman.dart' as hm;
import '../Algorithms/AES.dart';
import 'package:get_storage/get_storage.dart';

import 'transaction_page.dart';

class CreateAccPage extends StatefulWidget {
  @override
  State<CreateAccPage> createState() => _CreateAccPageState();
}

class _CreateAccPageState extends State<CreateAccPage> {
  final box = GetStorage();
  String studNum = '';
  String lastName = '';
  String firstName = '';
  String middleName = '';
  hm.Huffman huffman = hm.Huffman();

  void writeNFC() async {
    NFCData nfcData = NFCData(ID: studNum, FirstName: firstName);
    String encodedData = encodeNFCData(nfcData);
    String encryptedData = encryptAES(encodedData);
    box.write('NFCdata', encryptedData);
  }

  void addStudAcc() async {
    final studAcc = StudAcc(
      studNum: studNum,
      lastName: lastName,
      firstName: huffman.encode(firstName),
      middleName: middleName,
      balance: 0,
    );
    print("working");
    StudAccDB.instance.create(studAcc);
  }

  Widget buildStudNum() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Student Number',
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "201234567",
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
        onChanged: (value) => setState(() => studNum = value),
      );

  Widget buildLastName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Last Name',
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "e.g. Salazar",
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
        onChanged: (value) => setState(() => lastName = value),
      );
  Widget buildFirstName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'First Name',
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "e.g. Apollo Zeus",
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
        onChanged: (value) => setState(() => firstName = value),
      );
  Widget buildMiddleName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Middle Name',
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "e.g. Verano",
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
        onChanged: (value) => setState(() => middleName = value),
      );
  Widget button() => ElevatedButton(
        child: const Text(
          'Create',
        ),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF00523E),
            fixedSize: const Size(300, 40)),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WriteScan()));
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

              const SizedBox(height: 40),

              const Text(
                "Welcome to",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),
              // Logo
              // Paytriot

              const Text(
                "paytriot",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 36,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
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
                  const Text("Already have an account?",
                      style: TextStyle(
                        color: Color(0xFF9C9C9C),
                        fontSize: 12,
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WriteScan()));
                    },
                    child: const Text(
                      "Scan NFC Card",
                      style: TextStyle(fontSize: 12),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF00523E),
                      padding: EdgeInsets.zero,
                      minimumSize: Size(100, 30),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // Star Logo
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
