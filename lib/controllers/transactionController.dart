import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_pall_local_repo/controllers/accountController.dart';
import 'package:quick_pall_local_repo/models/AccountHolder.dart';
import 'package:quick_pall_local_repo/utils/AuditsAndLogs.dart';
import 'package:quick_pall_local_repo/viewModels/TransactionsViewModel.dart';

class TransactionController {
  static Map<String, dynamic> GetUserTransactionJSON(TransactionsViewModel t) {
    // final timestamp = FieldValue.serverTimestamp();
    return {
      "Amount": t.Money,
      "FriendId": t.Email,
      "IsActive": t.IsActive,
      "Reason": t.Reason,
      "TransactionType": t.transactionType,
      'createdAt': t.dateTime,
      'updatedAt': t.dateTime,
    };
  }

  static Future<List<TransactionsViewModel>?> GetTransactionsList(
      String UserEmail) async {
    try {
      Map<String, dynamic>? ContactsJSON =
          await getDocumentIfItExists("Transactions", UserEmail);
      if (ContactsJSON == null) return null;
      var FriendArray = ContactsJSON!["TransactionArray"];
      print(FriendArray[0]);
      print("Above is transactions Array");
      List<TransactionsViewModel> lst = [];
      for (DocumentReference element in FriendArray) {
        final firestore = FirebaseFirestore.instance;
        DocumentSnapshot transactionSnapShot = await element.get();

        print("Before get");
        print(element.id);
        print("After get");

        if (transactionSnapShot.exists) {
          // Document exists, you can access its data
          Map<String, dynamic> data =
              transactionSnapShot.data() as Map<String, dynamic>;
          if (data["FriendId"] != "Admin") {
            var friendDoc =
                await getDocumentIfItExists("AccountHolder", data["FriendId"]);
            if (data["IsActive"] == true) {
              TransactionsViewModel t = TransactionsViewModel(
                TransactionReference: element.id,
                Reason: data["Reason"],
                Image: friendDoc!["Image"],
                Email: friendDoc!["Email"],
                Money: data["Amount"],
                IsActive: data["IsActive"],
                Name: friendDoc!["Name"],
                dateTime: data["createdAt"].toDate(),
                transactionType: data["TransactionType"],
              );
              if (t.transactionType == "Sent" ||
                  t.transactionType == "Withdraw") {
                t.Money = "-" + t.Money;
              } else if (t.transactionType == "Recieve") {
                t.Money = "+" + t.Money;
              }
              lst.add(t);
            }
          } else {
            if (data["IsActive"] == true) {
              TransactionsViewModel t = TransactionsViewModel(
                TransactionReference: element.id,
                Reason: data["Reason"],
                Image:
                    "https://firebasestorage.googleapis.com/v0/b/quickpall.appspot.com/o/images%2Flogo.png?alt=media&token=75b49929-5231-4eb6-b6a3-7adf2978131c",
                Email: "Admin",
                Money: data["Amount"],
                IsActive: data["IsActive"],
                Name: "Admin",
                dateTime: data["createdAt"].toDate(),
                transactionType: data["TransactionType"],
              );
              if (t.transactionType == "Sent") {
                t.Money = "-" + t.Money;
              } else if (t.transactionType == "Recieve") {
                t.Money = "+" + t.Money;
              }
              lst.add(t);
            }
          }
        }
      }
      return lst;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "TransactionController", "GetTransactionsList");
      print(e);
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

  static Future<List<TransactionsViewModel>?> DeleteTransaction(
      String Id, TransactionsViewModel t) async {
    try {
      final timestamp = FieldValue.serverTimestamp();

      Map<String, dynamic> oldJson = GetUserTransactionJSON(t);
      Map<String, dynamic> newJson = GetUserTransactionJSON(t);
      newJson["IsActive"] = false;
      newJson["updatedAt"] = timestamp;
      var doc =
          FirebaseFirestore.instance.collection("UserTransactions").doc(Id);
      await doc.set(newJson);
      Auditer.PushAudit(oldJson, newJson, "UserTransactions");
    } catch (e) {
      Logger.PushLog(
          e.toString(), "TransactionController", "DeleteTransaction");
      print(e);
    }
  }

  static SendMoney(
      {required String SenderEmail,
      required String RecieverEmail,
      required String reason,
      required String amountToSend}) async {
    try {
      final timestamp = FieldValue.serverTimestamp();

      // Add sent transactions for sender
      var SendDoc =
          await FirebaseFirestore.instance.collection("UserTransactions").doc();
      Map<String, dynamic> SendJson = {
        "FriendId": RecieverEmail,
        "IsActive": true,
        "Amount": amountToSend,
        "Reason": reason,
        "TransactionType": "Sent",
        "createdAt": timestamp,
        "updatedAt": timestamp
      };
      await SendDoc.set(SendJson);
      await FirebaseFirestore.instance
          .collection("Transactions")
          .doc(SenderEmail)
          .set({
        "TransactionArray": FieldValue.arrayUnion([SendDoc])
      }, SetOptions(merge: true));
      //Update Sender
      Map<String, dynamic>? sJson =
          await getDocumentIfItExists("AccountHolder", SenderEmail);
      if (sJson != null) {
        AccountHolder? sObjectOld =
            AccountController.GetAccountHolderFromJson(sJson);
        AccountHolder? sObjectNew =
            AccountController.GetAccountHolderFromJson(sJson);
        if (sObjectNew != null && sObjectOld != null) {
          sObjectNew.Money = sObjectNew.Money - int.parse(amountToSend);
          AccountController.UpdateUser(
              OldData: sObjectOld, NewData: sObjectNew);
        }
      }
      // Add Recieve transactions for Reciever
      var RecieveDoc =
          await FirebaseFirestore.instance.collection("UserTransactions").doc();
      Map<String, dynamic> RecieveJson = {
        "FriendId": SenderEmail,
        "IsActive": true,
        "Amount": amountToSend,
        "Reason": reason,
        "TransactionType": "Recieve",
        "createdAt": timestamp,
        "updatedAt": timestamp
      };
      await RecieveDoc.set(RecieveJson);
      await FirebaseFirestore.instance
          .collection("Transactions")
          .doc(RecieverEmail)
          .set({
        "TransactionArray": FieldValue.arrayUnion([RecieveDoc])
      }, SetOptions(merge: true));

      //Update Reciever
      Map<String, dynamic>? rJson =
          await getDocumentIfItExists("AccountHolder", RecieverEmail);
      if (rJson != null) {
        AccountHolder? rObjectOld =
            AccountController.GetAccountHolderFromJson(rJson);
        AccountHolder? rObjectNew =
            AccountController.GetAccountHolderFromJson(rJson);
        if (rObjectNew != null && rObjectOld != null) {
          rObjectNew.Money = rObjectNew.Money + int.parse(amountToSend);
          AccountController.UpdateUser(
              OldData: rObjectOld, NewData: rObjectNew);
        }
      }
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "TransactionController", "SendMoney");
      print(e);
      return false;
    }
  }

  static MakeTransaction(
      {required String RecieverEmail,
      required String SenderEmail,
      required String TransactionType,
      required Amount,
      required String Reason}) async {
    try {
      final timestamp = FieldValue.serverTimestamp();

      // Add Recieve transactions for Reciever
      var RecieveDoc =
          await FirebaseFirestore.instance.collection("UserTransactions").doc();
      Map<String, dynamic> RecieveJson = {
        "FriendId": SenderEmail,
        "IsActive": true,
        "Amount": Amount,
        "Reason": Reason,
        "TransactionType": TransactionType,
        "createdAt": timestamp,
        "updatedAt": timestamp
      };
      await RecieveDoc.set(RecieveJson);
      await FirebaseFirestore.instance
          .collection("Transactions")
          .doc(RecieverEmail)
          .set({
        "TransactionArray": FieldValue.arrayUnion([RecieveDoc])
      }, SetOptions(merge: true));

      //Update Reciever
      Map<String, dynamic>? rJson =
          await getDocumentIfItExists("AccountHolder", RecieverEmail);
      if (rJson != null) {
        AccountHolder? rObjectOld =
            AccountController.GetAccountHolderFromJson(rJson);
        AccountHolder? rObjectNew =
            AccountController.GetAccountHolderFromJson(rJson);
        if (rObjectNew != null && rObjectOld != null) {
          rObjectNew.Money = rObjectNew.Money - int.parse(Amount);
          AccountController.UpdateUser(
              OldData: rObjectOld, NewData: rObjectNew);
        }
      }
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "TransactionController", "MakeTransaction");
      print(e);
      return false;
    }
  }
}
