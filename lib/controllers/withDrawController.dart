import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_pall_local_repo/utils/AuditsAndLogs.dart';

class WithDrawController {
  static Future<Map<String, dynamic>?> getDocumentIfItExists(
      String collectionName, String documentId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final DocumentSnapshot documentSnapshot =
          await firestore.collection(collectionName).doc(documentId).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      Logger.PushLog(
          e.toString(), "WithDrawController", "getDocumentIfItExists");
      return null;
    }
  }

  static OpenWithDrawWindow(String email) async {
    try {
      final timestamp = FieldValue.serverTimestamp();
      var WithdrawJson = await getDocumentIfItExists("WithdrawWindow", email);
      if (WithdrawJson == null) {
        // Document doesn't exist, create a new one
        print("Document does not exist. Creating a new one.");
        Map<String, dynamic> newJson = {
          "IsOpen": true,
          "createdAt": timestamp,
          "updatedAt": timestamp,
        };
        var doc =
            FirebaseFirestore.instance.collection("WithdrawWindow").doc(email);
        await doc.set(newJson);

        return true;
      }
      print("creating Jsons");
      Map<String, dynamic> oldJson = WithdrawJson!;
      Map<String, dynamic> newJson = {
        "IsOpen": true,
        "createdAt": oldJson["createdAt"],
        "updatedAt": timestamp
      };
      print("Jsons created");
      var doc =
          FirebaseFirestore.instance.collection("WithdrawWindow").doc(email);
      await doc.set(newJson);
      Auditer.PushAudit(oldJson, newJson, "WithDrawController");
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "WithDrawController", "OpenWithDrawWindow");
      return false;
    }
  }

  static CloseWithDrawWindow(String email) async {
    try {
      final timestamp = FieldValue.serverTimestamp();
      var WithdrawJson = await getDocumentIfItExists("WithdrawWindow", email);
      print("creating Jsons");
      Map<String, dynamic> oldJson = WithdrawJson!;
      Map<String, dynamic> newJson = {
        "IsOpen": false,
        "createdAt": oldJson["createdAt"],
        "updatedAt": timestamp
      };
      print("Jsons created");
      var doc =
          FirebaseFirestore.instance.collection("WithdrawWindow").doc(email);
      await doc.set(newJson);
      Auditer.PushAudit(oldJson, newJson, "WithDrawController");
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "WithDrawController", "CloseWithDrawWindow");
      return false;
    }
  }

  static GetIncomingRequestStream(String email) {
    try {
      return FirebaseFirestore.instance
          .collection("WithdrawIncomingRequest")
          .doc(email)
          .snapshots();
    } catch (e) {
      Logger.PushLog(
          e.toString(), "WithDrawController", "GetIncomingRequestStream");
      return null;
    }
  }

  static DeleteIncomingRequest(String email) async {
    try {
      final timestamp = FieldValue.serverTimestamp();
      var WithdrawJson =
          await getDocumentIfItExists("WithdrawIncomingRequest", email);
      print("creating Jsons");
      Map<String, dynamic> oldJson = WithdrawJson!;
      Map<String, dynamic> newJson = {
        "IsOpen": false,
        "Amount": "",
        "createdAt": timestamp,
        "updatedAt": timestamp
      };
      print("Jsons created");
      var doc = FirebaseFirestore.instance
          .collection("WithdrawIncomingRequest")
          .doc(email);
      await doc.set(newJson);
      Auditer.PushAudit(oldJson, newJson, "WithDrawController");
      return true;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "WithDrawController", "DeleteIncomingRequest");
      return false;
    }
  }
}
