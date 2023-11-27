import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_pall_local_repo/models/NotificationViewModel.dart';
import 'package:quick_pall_local_repo/utils/AuditsAndLogs.dart';

class NotificationController {
  static SendFriendRequestNotification(
      String senderEmail, String recieverEmail) async {
    try {
      final timestamp = FieldValue.serverTimestamp();

      var RequestDoc = await FirebaseFirestore.instance
          .collection("UserNotifications")
          .doc();

      Map<String, dynamic> RequestJson = {
        "FromEmail": senderEmail,
        "IsActive": true,
        "NotificationType": "Sent a friend request",
        "IsClicked": false,
        "IsResponded": false,
        "Amount": "",
        "createdAt": timestamp,
        "updatedAt": timestamp
      };

      await RequestDoc.set(RequestJson);

      await FirebaseFirestore.instance
          .collection("Notifications")
          .doc(recieverEmail)
          .set({
        "NotificationArray": FieldValue.arrayUnion([RequestDoc])
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "NotificationController",
          "SendFriendRequestNotification");
      print(e);
      return false;
    }
  }

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
          e.toString(), "TransactionController", "getDocumentIfItExists");
      return null;
    }
  }

  static GetAllNotifications(String UserEmail) async {
    try {
      Map<String, dynamic>? NotificationJSON =
          await getDocumentIfItExists("Notifications", UserEmail);
      if (NotificationJSON == null) return null;
      var NotificationArray = NotificationJSON!["NotificationArray"];
      print(NotificationArray[0]);
      print("Above is Notification Array");
      List<NotificationViewModel> lst = [];
      for (DocumentReference element in NotificationArray) {
        final firestore = FirebaseFirestore.instance;
        DocumentSnapshot NotificationSnapShot = await element.get();

        print("Before get");
        print(element.id);
        print("After get");

        if (NotificationSnapShot.exists) {
          // Document exists, you can access its data
          Map<String, dynamic> data =
              NotificationSnapShot.data() as Map<String, dynamic>;
          var SenderDoc =
              await getDocumentIfItExists("AccountHolder", data["FromEmail"]);
          if (data["IsActive"] == true) {
            NotificationViewModel t = NotificationViewModel(
                Id: element.id,
                Amount: data["Amount"],
                Image: SenderDoc!["Image"],
                FromEmail: SenderDoc!["Email"],
                IsActive: data["IsActive"],
                Name: SenderDoc!["Name"],
                createdAt: data["createdAt"].toDate(),
                updatedAt: data["updatedAt"].toDate(),
                IsClicked: data["IsClicked"],
                IsResponded: data["IsResponded"],
                NotificationType: data["NotificationType"]);
            lst.add(t);
          }
        } else {}
      }

      print('Liist Updated');
      return lst;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "NotificationController", "GetAllNotifications");
      print(e);
      return null;
    }
  }

  static Map<String, dynamic> GetNotificationJSON(NotificationViewModel n) {
    return {
      'Id': n.Id,
      'Amount': n.Amount,
      'FromEmail': n.FromEmail,
      'Image': n.Image,
      'IsActive': n.IsActive,
      'IsClicked': n.IsClicked,
      'IsResponded': n.IsResponded,
      'Name': n.Name,
      'NotificationType': n.NotificationType,
      'createdAt': n.createdAt, // Convert DateTime to String
      'updatedAt': n.updatedAt, // Convert DateTime to String
    };
  }

  static UpdateNotification(
      {required NotificationViewModel OldData,
      required NotificationViewModel NewData}) async {
    try {
      final timestamp = FieldValue.serverTimestamp();
      var Id = NewData.Id;
      print("creating Jsons");
      Map<String, dynamic> oldJson = GetNotificationJSON(OldData);
      Map<String, dynamic> newJson = GetNotificationJSON(NewData);
      print("Jsons created");
      newJson["updatedAt"] = timestamp;
      var doc =
          FirebaseFirestore.instance.collection("UserNotifications").doc(Id);
      await doc.set(newJson);
      print("User Updated");
      Auditer.PushAudit(oldJson, newJson, "UserNotifications");
      return true;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "NotificationController", "UpdateNotification");
      print(e);
      return false;
    }
  }

  static SetNotificationClicked(NotificationViewModel oldData) async {
    NotificationViewModel newData = NotificationViewModel.copy(oldData);
    newData.IsClicked = true;
    await UpdateNotification(OldData: oldData, NewData: newData);
  }

  static Map<String, dynamic> deepCopyMap(Map<dynamic, dynamic> original) {
    Map<String, dynamic> copy = {};

    original.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        // If the value is a nested map, recursively copy it
        copy[key.toString()] = deepCopyMap(value);
      } else if (value is List) {
        // If the value is a list, recursively copy each element
        copy[key.toString()] = List.from(
            value.map((item) => (item is Map) ? deepCopyMap(item) : item));
      } else {
        // Otherwise, copy the value directly
        copy[key.toString()] = value;
      }
    });

    return copy;
  }

  static MoneySentNotification(
      {required String senderEmail,
      required String recieverEmail,
      required String amount}) async {
    try {
      final timestamp = FieldValue.serverTimestamp();

      var RequestDoc = await FirebaseFirestore.instance
          .collection("UserNotifications")
          .doc();

      Map<String, dynamic> NotificationJson = {
        "FromEmail": senderEmail,
        "IsActive": true,
        "NotificationType": "Recieve",
        "IsClicked": false,
        "IsResponded": false,
        "Amount": amount,
        "createdAt": timestamp,
        "updatedAt": timestamp
      };

      await RequestDoc.set(NotificationJson);

      await FirebaseFirestore.instance
          .collection("Notifications")
          .doc(recieverEmail)
          .set({
        "NotificationArray": FieldValue.arrayUnion([RequestDoc])
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "NotificationController", "MoneySentNotification");
      print(e);
      return false;
    }
  }

  static SendMoneyRequest(
      {required String senderEmail,
      required String recieverEmail,
      required String requestedAmount}) async {
    try {
      final timestamp = FieldValue.serverTimestamp();

      var RequestDoc = await FirebaseFirestore.instance
          .collection("UserNotifications")
          .doc();

      Map<String, dynamic> NotificationJson = {
        "FromEmail": senderEmail,
        "IsActive": true,
        "NotificationType": "Requested",
        "IsClicked": false,
        "IsResponded": false,
        "Amount": requestedAmount,
        "createdAt": timestamp,
        "updatedAt": timestamp
      };

      await RequestDoc.set(NotificationJson);

      await FirebaseFirestore.instance
          .collection("Notifications")
          .doc(recieverEmail)
          .set({
        "NotificationArray": FieldValue.arrayUnion([RequestDoc])
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "NotificationController", "SendMoneyRequest");
      print(e);
      return false;
    }
  }

  static DeleteNotification(NotificationViewModel notification) async {
    try {
      final timestamp = FieldValue.serverTimestamp();

      Map<String, dynamic> oldJson = GetNotificationJSON(notification);
      Map<String, dynamic> newJson = GetNotificationJSON(notification);
      newJson["IsActive"] = false;
      newJson["updatedAt"] = timestamp;
      var doc = FirebaseFirestore.instance
          .collection("UserNotifications")
          .doc(notification.Id);
      await doc.set(newJson);
      Auditer.PushAudit(oldJson, newJson, "UserNotifications");
    } catch (e) {
      Logger.PushLog(
          e.toString(), "NotificationController", "DeleteNotification");
      print(e);
    }
  }
}
