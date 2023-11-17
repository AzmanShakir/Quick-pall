import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

class FriendsViewModel extends ISuspensionBean {
  FriendsViewModel(
      {required this.Name,
      required this.Email,
      required this.Image,
      required this.Tag,
      required this.ContactReference,
      required this.createdAt,
      required this.updatedAT});
  String Image;
  String Name;
  String Email;
  String Tag;
  DateTime createdAt;
  DateTime updatedAT;
  String ContactReference;
  @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    return Tag;
  }
}
