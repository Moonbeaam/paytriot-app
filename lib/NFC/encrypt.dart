import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final key = Key.fromUtf8(dotenv.env['KEY']!);
final b64key = Key.fromUtf8(base64Url.encode(key.bytes).substring(0,32));
final fernet = Fernet(b64key);
final encrypter = Encrypter(fernet);

Encrypted encrypt(data) {
  final encryptedData= encrypter.encrypt(data);
  return encryptedData;
}

String decrypt(String data) {
  final decryptedData = encrypter.decrypt(Encrypted.fromBase64(data));
  return decryptedData;
}