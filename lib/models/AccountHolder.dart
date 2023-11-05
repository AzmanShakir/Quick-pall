import 'package:cloud_firestore/cloud_firestore.dart';

class AccountHolder {
  AccountHolder(
      {required this.Country,
      required this.Email,
      required this.Image,
      required this.Money,
      required this.Name,
      required this.Password,
      required this.Phone,
      required this.IsActive,
      required this.Pin,
      this.CreatedAt = null,
      this.UpdatedAt = null});

  String Email;
  String Password;
  String Name;
  String Country;
  String Phone;
  String Pin;
  String Image;
  int Money;
  bool IsActive;
  Timestamp? CreatedAt;
  Timestamp? UpdatedAt;
}
