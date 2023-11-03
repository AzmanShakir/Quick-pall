import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '/models/Country.dart';

class CountryController {
  static Stream<List<Country>> getCountries() {
    var ss = FirebaseFirestore.instance.collection("Country").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Country.FromJson(doc.data(), doc.id))
            .toList());
    return ss;
  }
}
