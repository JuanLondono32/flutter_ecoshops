import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntrepreneurshipService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late DocumentReference _entrepreneurship;

  EntrepreneurshipService();

  Future register(Map newEntrep, String userID) async {
    newEntrep["id_user"] = userID;
    _entrepreneurship = _firestore.collection("entrepreneurship").doc();
    await _entrepreneurship.set(newEntrep);

    var _user = _firestore.collection("user").doc(userID);
    await _user.update({"role": "e"});
  }
}
