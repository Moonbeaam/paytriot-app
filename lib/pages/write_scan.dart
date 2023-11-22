import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:get_storage/get_storage.dart';
import 'package:paytriot/pages/menu_page.dart';
import 'package:paytriot/pages/sign_up_login_page.dart';

class WriteScan extends StatefulWidget {
  @override
  State<WriteScan> createState() => _WriteScanState();
}

class _WriteScanState extends State<WriteScan> {
  final box = GetStorage();
  
  @override
  
  void initState() {
    super.initState();
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => Sign_Up_Login_Page()));
        }
      },
    );
    
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
                "Welcome back to",
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

              const SizedBox(height: 60),

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


              const SizedBox(height: 1),

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