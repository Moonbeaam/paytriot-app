import 'dart:convert';

class NFCData {
  final String ID;

  NFCData({required this.ID});

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
    };
  }

  factory NFCData.fromMap(Map<String, dynamic> map) {
    return NFCData(
      ID: map['ID'],
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


