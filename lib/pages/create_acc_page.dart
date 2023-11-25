import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:paytriot/pages/write_scan_page.dart';
import 'package:sqflite/sqflite.dart';
import '../NFC/NFC.dart';
import '../Algorithms/huffman.dart' as hm;
import '../Algorithms/AES.dart';
import 'package:get_storage/get_storage.dart';

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
  String errorMsg="";
  hm.Huffman huffman = hm.Huffman();

  void writeNFC() async {
    NFCData nfcData = NFCData(ID: studNum, FirstName: firstName, MiddleName: middleName, LastName: lastName);
    String encodedData = encodeNFCData(nfcData);
    String encryptedData = encryptAES(encodedData);
    print("AES Encryption \nEncrypted Data: ${encryptedData}");
    box.write('NFCdata', encryptedData);
  }

  Future<void> addStudAcc() async {
    try {
      final studAcc = StudAcc(
        studNum: studNum,
        lastName: huffman.encode(lastName),
        firstName: huffman.encode(firstName),
        middleName: middleName.isNotEmpty ? huffman.encode(middleName) : '',
        balance: 0,
      );
      print("Huffman Coding\nFirst Name:${studAcc.firstName}, Middle Name: ${studAcc.middleName}, Last Name: ${studAcc.lastName}");
      await StudAccDB.instance.create(studAcc);
      writeNFC();
      // Note: Navigator should be outside the try-catch block
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WriteScan()));
    } catch (e) {
      if (e is DatabaseException) {
        // Handle DatabaseException
        errorMsg = "Account already exists";
        print("DatabaseException: $e");
        // Trigger a rebuild to show the error message
        setState(() {});
      } else {
        // Handle other exceptions
        print("Unexpected exception: $e");
      }
    }
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
        onChanged: (value) => setState(() => lastName = value.toUpperCase()),
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
        onChanged: (value) => setState(() => firstName = value.toUpperCase()),
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
        onChanged: (value) => setState(() => middleName = value.toUpperCase()),
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
          addStudAcc();
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    Navigator.pop(context);
                  },
                ),
              ),
          Expanded( // Wrap the main column with Expanded
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Welcome to",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
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
                  const SizedBox(height: 16),
                  button(),
                  const SizedBox(height: 16),
                  Text(
                    '${errorMsg}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Color(0xFF9C9C9C),
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WriteScan(),
                            ),
                          );
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
                  const SizedBox(height: 50),
                  // Star Logo
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/star_logo.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  // Powered by...
                  const Text(
                    "Powered by DLSU-D CSCS Students",
                    style: TextStyle(
                      color: Color(0xFF00523E),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    ),
    );
  }
}
