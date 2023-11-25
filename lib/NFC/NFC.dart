import 'dart:convert';

class NFCData {
  final String ID;
  final String FirstName;
  final String MiddleName;
  final String LastName;
  NFCData({required this.ID,required this.FirstName, required this.MiddleName, required this.LastName});

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'FirstName': FirstName,
      'MiddleName': MiddleName,
      'LastName': LastName,
    };
  }

  factory NFCData.fromMap(Map<String, dynamic> map) {
    return NFCData(
      ID: map['ID'],
      FirstName: map['FirstName'],
      MiddleName: map['MiddleName'],
      LastName: map['LastName'],
    );
  }
}

String encodeNFCData(NFCData data) {
  final jsonData = data.toMap();
  return jsonEncode(jsonData);
}

NFCData decodeNFCData(String encodedData) {
  final Map<String, dynamic> jsonData = jsonDecode(encodedData);
  return NFCData.fromMap(jsonData);
}


