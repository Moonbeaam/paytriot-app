import 'package:flutter/material.dart';
import 'package:paytriot/pages/cash_in_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:get_storage/get_storage.dart';
import '../NFC/NFC.dart';
import '../Algorithms/AES.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';

class Tap_ID_Page extends StatefulWidget {
  const Tap_ID_Page({super.key});

  @override
  State<Tap_ID_Page> createState() => _Tap_ID_PageState();
}

class _Tap_ID_PageState extends State<Tap_ID_Page> {
  String studNum = '';
  String displayText = '';
  String cashInAmount = '';
  late StudAcc studentAccount;
  final box = GetStorage();

  void scan() async{
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
          }
        }
    );
  }

  void getStudAcc() async {
    try {
        final result = await StudAccDB.instance.readAcc(box.read('studNum')); // Use your readAcc function
            if(result!=null){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CashInPage()));
            }
    } catch (e) {
      setState(() {
        displayText = e.toString();
      });
    }
  }
  
  void getStudNum() async {
    await GetStorage.init();
    box.write('studNum', studNum).toString();

    getStudAcc();
  }
  
  @override
  void initState() {
    super.initState();
    scan();
    getStudNum();
    getStudAcc();
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
              
              // Paytriot
              const Text(
                "paytriot",
                style: TextStyle(
                  color: Color(0xFF00523E),
                  fontSize: 20,
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
                "Tap your NFC card to continue",
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

              const SizedBox(height: 70),

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