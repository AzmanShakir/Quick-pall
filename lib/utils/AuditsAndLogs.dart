import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import '/models/AccountHolder.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';

class Logger {
  static PushLog(String logMessage, String clas, String fucn) async {
    try {
      var doc = FirebaseFirestore.instance.collection("Logs").doc();
      final timestamp = FieldValue.serverTimestamp();
      await doc.set({
        "Message": logMessage,
        "ClassName": clas,
        "FucntionName": fucn,
        'createdAt': timestamp,
      });
    } catch (e) {
      print(e);
    }
  }
}
