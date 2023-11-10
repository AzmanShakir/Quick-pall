import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
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
      var doc = FirebaseFirestore.instance
          .collection("AccountHolder")
          .doc(user.Email);
      await doc.set(GetJSON(user));
      return true;
    } catch (e) {
      Logger.PushLog(e.toString(), "AccountController", "CreateAccount");
      print(e);
      return false;
    }
  }

  static Map<String, dynamic> GetJSON(AccountHolder user) {
    final timestamp = FieldValue.serverTimestamp();
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
      'CreatedAt': timestamp,
      'UpdatedAt': timestamp,
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
          CreatedAt: userJson["CreatedAt"],
          UpdatedAt: userJson["UpdatedAt"]);
      return user;
    } catch (e) {
      Logger.PushLog(
          e.toString(), "AccountController", "GetAccountHolderFromJson");
      print(e);

      return null;
    }
  }

  static Future<List<TransactionsViewModel>?> GetTransactionsList(
      String UserEmail) async {
    try {
      Map<String, dynamic>? transactionsJson =
          await getDocumentIfItExists("Transactions", UserEmail);
      if (transactionsJson == null) return null;
      var transactionArray = transactionsJson!["TransactionArray"];
      print(transactionArray[0]);
      print("Above is transactions Array");
      List<TransactionsViewModel> lst = [];
      // transactionArray.forEach((DocumentReference element) async {
      //   final firestore = FirebaseFirestore.instance;
      //   DocumentSnapshot transactionSnapShot = await element.get();

      //   print("Before get");
      //   print(transactionSnapShot);
      //   print("after get");
      //   if (transactionSnapShot.exists) {
      //     // Document exists, you can access its data
      //     Map<String, dynamic> data =
      //         transactionSnapShot.data() as Map<String, dynamic>;
      //     TransactionsViewModel t = TransactionsViewModel(
      //         Image: "Image",
      //         Money: data["Amount"],
      //         Name: data["FriendId"],
      //         dateTime: data["createdAt"],
      //         transactionType: data["TransactionType"]);
      //     lst.add(t);
      //     print('Document data: $data');
      //   } else {
      //     print('Transaction does not exist');
      //   }
      // });
      for (DocumentReference element in transactionArray) {
        final firestore = FirebaseFirestore.instance;
        DocumentSnapshot transactionSnapShot = await element.get();

        print("Before get");
        print(transactionSnapShot);
        print("After get");

        if (transactionSnapShot.exists) {
          // Document exists, you can access its data
          Map<String, dynamic> data =
              transactionSnapShot.data() as Map<String, dynamic>;

          TransactionsViewModel t = TransactionsViewModel(
            Image: "Image",
            Money: data["Amount"],
            Name: data["FriendId"],
            dateTime: data["createdAt"].toDate(),
            transactionType: data["TransactionType"],
          );

          lst.add(t);
        } else {
          print('Transaction does not exist');
        }
      }
      return lst;
    } catch (e) {
      Logger.PushLog(e.toString(), "AccountController", "GetTransactionsList");
      print(e);
    }
  }
}
