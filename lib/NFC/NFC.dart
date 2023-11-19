import 'dart:convert';

class NFCData {
  final String ID;
  final String FirstName;

  NFCData({required this.ID,required this.FirstName});

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'FirstName': FirstName,
    };
  }

  factory NFCData.fromMap(Map<String, dynamic> map) {
    return NFCData(
      ID: map['ID'],
      FirstName: map['FirstName'],
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


