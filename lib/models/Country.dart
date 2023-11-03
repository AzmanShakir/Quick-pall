import 'package:cloud_firestore/cloud_firestore.dart';

class Country {
  String code;
  String iconCode;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String id;
  bool active;
  Country(
      {required this.id,
      required this.active,
      required this.name,
      required this.code,
      required this.iconCode,
      required this.createdAt,
      required this.updatedAt});

  static Country FromJson(Map<String, dynamic> json, String Id) {
    return Country(
      code: json["Code"],
      iconCode: json["IconCode"],
      name: json["Name"],
      active: json["Active"],
      createdAt: (json["CreatedAt"] as Timestamp).toDate(),
      updatedAt: (json["UpdatedAt"] as Timestamp).toDate(),
      id: Id,
    );
  }
}
