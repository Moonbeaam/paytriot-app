import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:get_storage/get_storage.dart';
import '../pages/home_page.dart';
import '../NFC/NFC.dart';
import '../Algorithms/AES.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';

class WriteScan extends StatefulWidget {
  @override
  State<WriteScan> createState() => _WriteScanState();
}

class _WriteScanState extends State<WriteScan> {
  String studNum = '';
  String displayText='';
  String balText='';
  final box = GetStorage();
  
  void scan(){
    NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          Ndef? ndef = Ndef.from(tag);
          NdefMessage? ndefMessage = await ndef?.read();
          if (ndefMessage != null) {
            List<NdefRecord> records = ndefMessage.records;
            for (NdefRecord record in records) {
              if (record.payload != null) {
                String encodedData = String.fromCharCodes(record.payload);
                print('Encoded Data: $encodedData');
                try {
                  String decryptedData = decryptAES(encodedData);  // Assuming decrypt returns a String
                  print('Decrypted Data: $decryptedData');
                  NFCData nfcData = decodeNFCData(decryptedData);
                  studNum = nfcData.ID;
                  box.write('firstName', nfcData.FirstName).toString();
                  setState(() {
                    displayText = studNum;
                  });
                  break; // Exit the loop after processing the first record
                } catch (e) {
                  print("Error during decryption: $e");
                }
              }
            }
            box.write('studNum', studNum).toString();
            getStudAcc();
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Page()));
          }
        }
    );
  }

  void getStudAcc() async {
    try {
        final result = await StudAccDB.instance.readAcc(box.read('studNum')); // Use your readAcc function
        
            
          
        }
     catch (e) {
      setState(() {
        displayText = e.toString();
      });
    }
  }
  void write() async{
    String data= box.read('NFCdata');
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        Ndef? ndef = Ndef.from(tag);
        if (ndef != null && ndef.isWritable) {
          List<NdefRecord> records = [
            NdefRecord.createMime(
              'application/json',Uint8List.fromList(utf8.encode(data)),
            ),
          ];
          NdefMessage ndefMessage = NdefMessage(records);

          await ndef?.write(ndefMessage);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Page()));
        }
      },
    );
  }

  void getStudNum() async {
    await GetStorage.init();
    box.write('studNum', studNum).toString();
  }
  @override

  void initState() {
    super.initState();
    if (box.read('page')=='Create'){
      write();
    }
    else if(box.read('page')=='Scan'){
      scan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),

              // Welcome back to
              const Text(
                "Welcome to",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800
                ),
              ),

              // Paytriot
              const Text(
                "paytriot",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 32,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 120),

              // Tap NFC Icon
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/nfc_tap.png'),
                    fit: BoxFit.fitWidth,
                  )
                ),
              ),

              const SizedBox(height: 20),

              // Tap Text
              const Text(
                "Tap your NFC card to write",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800
                ),
              ),

              const SizedBox(height: 60),

              LoadingAnimationWidget.twoRotatingArc(
                color: Color(0xFF00523E),
                size: 40
              ),
              
              const SizedBox(height: 40),

              // Star Logo
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
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
                )
              )
            ]
          )
        )
      )
    );
  }
}