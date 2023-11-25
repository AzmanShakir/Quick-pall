// import 'dart:js_util';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quick_pall_local_repo/models/AddFriendViewModel.dart';
import 'package:quick_pall_local_repo/models/FriendsViewModel.dart';
import 'package:quick_pall_local_repo/viewModels/TransactionsViewModel.dart';
import '/models/AccountHolder.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:quick_pall_local_repo/utils/AuditsAndLogs.dart';

class AccountController {
  static Future<String> getApplicationDocumentsPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> createImageFile(Uint8List imageBytes) async {
    final String documentsPath = await getApplicationDocumentsPath();
    final String filePath = '$documentsPath/temp_image.jpg';
    return File(filePath)..writeAsBytes(imageBytes);
  }

  static Future<String> UploadImage(Uint8List imageBytes) async {
// Create a temporary File to store the image
    File img = await createImageFile(imageBytes) as File;
    String url = "-1";
    try {
      final FirebaseStorage _storage = FirebaseStorage.instance;
      final reference =
          _storage.ref('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = reference.putFile(img);
      await uploadTask.whenComplete(() async {
        String imageUrl = await reference.getDownloadURL();
        print('Image uploaded and URL is $imageUrl');
        url = imageUrl;
      });
      return url;
    } catch (e) {
      print('Error uploading image: $e');
      Logger.PushLog(e.toString(), "AccountController", "UploadImage");
      return "-1";
    }
    return "-1";
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
          e.toString(), "AccountController", "getDocumentIfItExists");
      return null;
    }
  }

  static Future<bool> CreateAccount(AccountHolder user) async {
    try {
      final timestamp = FieldValue.serverTimestamp();
      var doc = FirebaseFirestore.instance
          .collection("AccountHolder")
          .doc(user.Email);
      Map<String, dynamic> json = GetAccountHolderJSON(user);
      json["createdAt"] = timestamp;
      json["updatedAt"] = timestamp;
      await doc.set(json);
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "AccountController", "CreateAccount");
      print(e);
      return false;
    }
  }

  static Map<String, dynamic> GetAccountHolderJSON(AccountHolder user) {
    return {
      "Email": user.Email,
      "Password": user.Password,
      "Name": user.Name,
      "Country": user.Country,
      "Phone": user.Phone,
      "Pin": user.Pin,
      "Image": user.Image,
      "Money": user.Money,
      "IsActive": user.IsActive,
      'createdAt': user.CreatedAt,
      'updatedAt': user.UpdatedAt,
    };
  }

  static Future<AccountHolder?> SignIn(email, password) async {
    try {
      Map<String, dynamic>? userJson =
          await getDocumentIfItExists("AccountHolder", email);
      if (userJson == null) return null;
      if (userJson!["Password"] != password) return null;
      AccountHolder? user = GetAccountHolderFromJson(userJson);
      return user;
    } catch (e) {
      Logger.PushLog(e.toString(), "AccountController", "SignIn");
      print(e);
      return null;
    }
  }

  static AccountHolder? GetAccountHolderFromJson(
      Map<String, dynamic> userJson) {
    try {
      AccountHolder? user = null;
      user = AccountHolder(
          Country: userJson["Country"].toString(),
          Email: userJson["Email"].toString(),
          Image: userJson["Image"].toString(),
          Money: int.parse(userJson["Money"].toString()),
          Name: userJson["Name"].toString(),
          Password: userJson["Password"].toString(),
          Phone: userJson["Phone"].toString(),
          IsActive: userJson["IsActive"],
          Pin: userJson["Pin"].toString(),
          CreatedAt: userJson["createdAt"],
          UpdatedAt: userJson["updatedAt"]);
      print("this is time stamp" + user.CreatedAt.toString());
      return user;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "AccountController", "GetAccountHolderFromJson");
      print(e);

      return null;
    }
  }

  static UpdateUser(
      {required AccountHolder OldData, required AccountHolder NewData}) async {
    try {
      final timestamp = FieldValue.serverTimestamp();
      var Id = NewData.Email;
      print("creating Jsons");
      print(NewData.Email);
      print(NewData.CreatedAt);
      print(OldData.CreatedAt);
      Map<String, dynamic> oldJson = GetAccountHolderJSON(OldData);
      Map<String, dynamic> newJson = GetAccountHolderJSON(NewData);
      print("Jsons created");
      newJson["updatedAt"] = timestamp;
      var doc = FirebaseFirestore.instance.collection("AccountHolder").doc(Id);
      await doc.set(newJson);
      print("User Updated");
      Auditer.PushAudit(oldJson, newJson, "AccountHolder");
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "AccountController", "UpdateUser");
      print(e);
      return false;
    }
  }
}
