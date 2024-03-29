  import 'dart:convert';
  import 'dart:typed_data';
  import 'package:encrypt/encrypt.dart';
  import 'dart:math';
  import 'package:flutter_dotenv/flutter_dotenv.dart';

  final keyBase64 = dotenv.env['KEY']!;
  final keyBytes = base64Url.decode(keyBase64);
  final key = Key(Uint8List.fromList(keyBytes));
  final secretKey = Key(Uint8List.fromList(keyBytes.sublist(0, min(32, keyBytes.length))));

  String encryptAES(String plainText) {
    final keyBytes = secretKey.bytes;
    final iv = IV.fromSecureRandom(16);

    final encrypter = Encrypter(AES(Key(Uint8List.fromList(keyBytes)), mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // Concatenate IV and encrypted text, and then convert to base64
    final combined = Uint8List.fromList([...iv.bytes, ...encrypted.bytes]);
    return base64Encode(combined);
  }

  String decryptAES(String encryptedText) {
    final keyBytes = secretKey.bytes;

    // Decode base64 to get IV and encrypted text
    final combinedBytes = base64Decode(encryptedText);
    final iv = IV(Uint8List.fromList(combinedBytes.sublist(0, 16)));
    final encryptedTextBytes = Uint8List.fromList(combinedBytes.sublist(16));

    final encrypter = Encrypter(AES(Key(Uint8List.fromList(keyBytes)), mode: AESMode.cbc));
    final decryptedString = encrypter.decrypt(Encrypted(encryptedTextBytes), iv: iv);

    return decryptedString;
  }

