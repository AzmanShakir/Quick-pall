import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_pall_local_repo/models/AddFriendViewModel.dart';
import 'package:quick_pall_local_repo/models/FriendsViewModel.dart';
import 'package:quick_pall_local_repo/utils/AuditsAndLogs.dart';

class ContactController {
  static GetFriend(String UserEmail, String FriendEmail) async {
    try {
      Map<String, dynamic>? ContactsJSON =
          await getDocumentIfItExists("Contacts", UserEmail);
      if (ContactsJSON == null) return null;
      var FriendArray = ContactsJSON!["FriendArray"];
      for (DocumentReference element in FriendArray) {
        final firestore = FirebaseFirestore.instance;
        DocumentSnapshot ContactSnapShot = await element.get();
        if (ContactSnapShot.exists) {
          // Document exists, you can access its data
          Map<String, dynamic> data =
              ContactSnapShot.data() as Map<String, dynamic>;
          var UserContact =
              await getDocumentIfItExists("UserContacts", element.id);
          if (UserContact!["FriendEmail"] == FriendEmail &&
              UserContact!["IsActive"] == true) return element;
        }
      }
      return null;
    } catch (e) {
      Logger.PushLog(e.toString(), "ContactController", "GetFriend");
      print(e);
    }
  }

  static Future<AddFriendViewModel?> GetAccountHolderAsContact(
      String UserEmail, String FriendEmail) async {
    try {
      Map<String, dynamic>? userJson =
          await getDocumentIfItExists("AccountHolder", FriendEmail);
      if (userJson == null) return null;
      print("Friend Found");
      DocumentReference? UserContactElement =
          await GetFriend(UserEmail, FriendEmail);
      print(UserContactElement);
      AddFriendViewModel? user;
      if (UserContactElement == null)
        user = GetAddFriendViewModelFromJson(userJson, false);
      else
        user = GetAddFriendViewModelFromJson(userJson, true);
      return user;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "ContactController", "GetAccountHolderAsContact");
      print(e);
      return null;
    }
  }

  static Future<List<FriendsViewModel>?> GetFriendsList(
      String UserEmail) async {
    try {
      Map<String, dynamic>? ContactsJSON =
          await getDocumentIfItExists("Contacts", UserEmail);
      if (ContactsJSON == null) return null;
      var FriendArray = ContactsJSON!["FriendArray"];
      print(FriendArray[0]);
      print("Above is Friend Array");
      List<FriendsViewModel> lst = [];
      for (DocumentReference element in FriendArray) {
        final firestore = FirebaseFirestore.instance;
        DocumentSnapshot ContactSnapShot = await element.get();

        print("Before get");
        print(element.id);
        print("After get");

        if (ContactSnapShot.exists) {
          // Document exists, you can access its data
          Map<String, dynamic> data =
              ContactSnapShot.data() as Map<String, dynamic>;
          var UserContact =
              await getDocumentIfItExists("UserContacts", element.id);
          var FriendData = await getDocumentIfItExists(
              "AccountHolder", UserContact!["FriendEmail"]);
          // print(FriendData);
          String Name = FriendData!["Name"];
          if (UserContact["IsActive"] == true) {
            FriendsViewModel t = FriendsViewModel(
                ContactReference: element.id,
                Image: FriendData!["Image"],
                Email: FriendData!["Email"],
                Name: FriendData!["Name"],
                createdAt: UserContact["createdAt"].toDate(),
                updatedAT: UserContact["updatedAt"].toDate(),
                Tag: Name[0]);
            lst.add(t);
          }
        } else {
          print('Friend does not exist');
        }
      }
      print("List Created Successfluu");

      // for (int i = 65; i <= 96; i++) {
      //   // 97 is the ASCII code for 'a', and 122 is the ASCII code for 'z'
      //   String letter = String.fromCharCode(i);
      //   FriendsViewModel t = FriendsViewModel(
      //       ContactReference: "element.id",
      //       Image: "FriendData![]",
      //       Email: "FriendData![]",
      //       Name: letter,
      //       createdAt: DateTime.now(),
      //       updatedAT: DateTime.now(),
      //       Tag: letter);
      //   lst.add(t);
      // }

      return lst;
    } catch (e) {
      Logger.PushLog(e.toString(), "ContactController", "GetFriendsList");
      print(e);
    }
  }

  static Future<bool> DeleteFriend(FriendsViewModel friend) async {
    try {
      final timestamp = FieldValue.serverTimestamp();
      Map<String, dynamic> oldJson = GetUserContactJSON(friend);
      Map<String, dynamic> newJson = GetUserContactJSON(friend);
      newJson["IsActive"] = false;
      newJson["updatedAt"] = timestamp;
      var doc = FirebaseFirestore.instance
          .collection("UserContacts")
          .doc(friend.ContactReference);
      await doc.set(newJson);
      Auditer.PushAudit(oldJson, newJson, "UserContacts");
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "ContactController", "DeleteFriend");
      print(e);
      return false;
    }
  }

  static Map<String, dynamic> GetUserContactJSON(FriendsViewModel friend) {
    return {
      "FriendEmail": friend.Email,
      "IsActive": true,
      "createdAt": friend.createdAt,
      "updatedAt": friend.updatedAT,
    };
  }

  static AddFriendViewModel? GetAddFriendViewModelFromJson(
      Map<String, dynamic> userJson, bool isFriend) {
    try {
      AddFriendViewModel? user = null;
      user = AddFriendViewModel(
          Email: userJson["Email"].toString(),
          Image: userJson["Image"].toString(),
          Name: userJson["Name"].toString(),
          IsAlreadyFriend: isFriend);
      return user;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "ContactController", "GetAddFriendViewModelFromJson");
      print(e);

      return null;
    }
  }

  static AddContact(String UserEmail, String FriendEmail) async {
    try {
      final timestamp = FieldValue.serverTimestamp();

      DocumentReference? ref =
          await IsFriendAlreadyExist(UserEmail, FriendEmail);
      if (ref != null) {
        print(ref.id);
        var oldDoc = await getDocumentIfItExists("UserContacts", ref.id);
        var newDoc = deepCopyMap(oldDoc!);
        newDoc!["IsActive"] = true;
        newDoc!["updatedAt"] = timestamp;
        var doc = await FirebaseFirestore.instance
            .collection("UserContacts")
            .doc(ref.id);
        doc.set(newDoc);
        Auditer.PushAudit(oldDoc, newDoc, "UserContacts");
        return true;
      } else {
        var doc =
            await FirebaseFirestore.instance.collection("UserContacts").doc();
        Map<String, dynamic> json = {
          "FriendEmail": FriendEmail,
          "IsActive": true,
          "createdAt": timestamp,
          "updatedAt": timestamp
        };
        await doc.set(json);
        await FirebaseFirestore.instance
            .collection("Contacts")
            .doc(UserEmail)
            .update({
          "FriendArray": FieldValue.arrayUnion([doc])
        });
        return true;
      }
    } catch (e) {
      Logger.PushLog(e.toString(), "ContactControllerr", "AddContact");
      print(e);
      return false;
    }
  }

  static IsFriendAlreadyExist(String UserEmail, String FriendEmail) async {
    try {
      Map<String, dynamic>? ContactsJSON =
          await getDocumentIfItExists("Contacts", UserEmail);
      if (ContactsJSON == null) return null;
      var FriendArray = ContactsJSON!["FriendArray"];
      for (DocumentReference element in FriendArray) {
        final firestore = FirebaseFirestore.instance;
        DocumentSnapshot ContactSnapShot = await element.get();
        if (ContactSnapShot.exists) {
          // Document exists, you can access its data
          Map<String, dynamic> data =
              ContactSnapShot.data() as Map<String, dynamic>;
          var UserContact =
              await getDocumentIfItExists("UserContacts", element.id);
          if (UserContact!["FriendEmail"] == FriendEmail) return element;
        }
      }
      return null;
    } catch (e) {
      Logger.PushLog(e.toString(), "ContactController", "IsFriendAlreadyExist");
      print(e);
    }
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

  static DeleteContact(String UserEmail, String FriendEmail) async {
    try {
      final timestamp = FieldValue.serverTimestamp();
      DocumentReference ref = await GetFriend(UserEmail, FriendEmail);
      var oldDoc = await getDocumentIfItExists("UserContacts", ref.id);
      var newDoc = deepCopyMap(oldDoc!);
      newDoc!["IsActive"] = false;
      newDoc!["updatedAt"] = timestamp;
      await FirebaseFirestore.instance
          .collection("UserContacts")
          .doc(ref.id)
          .set(newDoc);
      Auditer.PushAudit(oldDoc, newDoc, "UserContacts");
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "ContactController", "DeleteContact");
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
          e.toString(), "ContactController", "getDocumentIfItExists");
      return null;
    }
  }
}
