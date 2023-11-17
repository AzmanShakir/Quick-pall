import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import '/models/AccountHolder.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';

class Logger {
  static PushLog(String logMessage, String clas, String fucn) async {
    try {
      final timestamp = FieldValue.serverTimestamp();
      DateTime dateTime = DateTime.now();

      var doc = FirebaseFirestore.instance.collection("Logs").doc(clas +
          " " +
          fucn +
          " " +
          DateFormat('h:mm a').format(dateTime).toString());
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

class Auditer {
  static PushAudit(Map<String, dynamic> oldData, Map<String, dynamic> newData,
      String CollectionName) async {
    try {
      DateTime dateTime = DateTime.now();

      Map<String, dynamic> OldmodifiedMap = addPrefixToKeys(oldData, 'old');
      Map<String, dynamic> NewmodifiedMap = addPrefixToKeys(newData, 'new');
      Map<String, dynamic> AuditDoc = {...OldmodifiedMap, ...NewmodifiedMap};
      AuditDoc["CollectionName"] = CollectionName;
      var doc1 = FirebaseFirestore.instance.collection("Audits").doc(
          CollectionName +
              " " +
              DateFormat('h:mm a').format(dateTime).toString());
      await doc1.set(AuditDoc);
    } catch (e) {
      print(e);
    }
  }

  static Map<String, dynamic> addPrefixToKeys(
      Map<String, dynamic> originalMap, String prefix) {
    return Map.fromEntries(originalMap.entries
        .map((entry) => MapEntry('$prefix${entry.key}', entry.value)));
  }
}
