import 'package:flutter/material.dart';
import 'package:paytriot/DB/stud_acc_db.dart';
import 'package:paytriot/model/stud_acc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paytriot/pages/cash_in_page.dart';
import 'package:paytriot/pages/purchase_page.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../NFC/NFC.dart';
import '../NFC/encrypt.dart';

class ReadIdPage extends StatefulWidget {
  @override

  State<ReadIdPage> createState() => _ReadIdPageState();
}

class _ReadIdPageState extends State<ReadIdPage> {
  String studNum = '';
  String displayText='';
  String balText='';
  late StudAcc studentAccount;
  final box = GetStorage();
  late NfcManager nfcManager;

  @override
  void initState() {
    super.initState();
    setState(() {
      displayText = "TAp NFC CARD";
    });

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
                  String decryptedData = decrypt(encodedData);  // Assuming decrypt returns a String
                  print('Decrypted Data: $decryptedData');
                  NFCData nfcData = decodeNFCData(decryptedData);
                  studNum = nfcData.ID;
                  setState(() {
                    displayText = studNum;
                  });
                  break; // Exit the loop after processing the first record
                } catch (e) {
                  print('Error during decryption: $e');
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
          if(box.read('action')=='CashIn'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CashInPage()));
          }
          else if(box.read('action')=='Purchase'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PurchasePage()));
          }
        }
        else{
          setState(() {
            displayText = "asdasd";
          });
        }

    } catch (e) {
      setState(() {
        displayText = Exception(e).toString();
      });
    }
  }
  void getStudNum() async {
    await GetStorage.init();
    box.write('studNum', studNum).toString();
    getStudAcc();
  }

  Widget buildStudNum() => TextFormField(
    decoration: const InputDecoration(
      labelText: 'StudentNumber',
      border: OutlineInputBorder(),
    ),
    onChanged: (value) => setState(() => studNum = value),
  );

  Widget button() => TextButton(
    onPressed: getStudNum,
    child: const Text(
      'Search',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          buildStudNum(),
          const SizedBox(height: 16, width: 5),
          button(),
          Text(
              displayText
          )
        ],
      ),
    );
  }
}
