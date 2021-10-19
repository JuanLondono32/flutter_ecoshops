import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecoshops/models/entrepreneurship.dart';

class EntrepreneurshipService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _entrepreneurship;

  EntrepreneurshipService();

  Future register(Map newEntrep, String userID) async {
    newEntrep["id_user"] = userID;
    _entrepreneurship = _firestore.collection("entrepreneurship");
    await _entrepreneurship.doc().set(newEntrep);

    var _user = _firestore.collection("user").doc(userID);
    await _user.update({"role": "e"});
  }

  Future<Entrepreneurship> getProfile(String entrepreneurshipID) async {
    _entrepreneurship = _firestore.collection("entrepreneurship");
    var query = await _entrepreneurship.doc(entrepreneurshipID).get();

    var profile = query.data();

    return new Entrepreneurship.fromMap(profile as dynamic);
  }

  Future<Entrepreneurship> getProfileByUserId(String userID) async {
    _entrepreneurship = _firestore.collection("entrepreneurship");
    var query =
        await _entrepreneurship.where("id_user", isEqualTo: userID).get();

    var profile = query.docs[0].data();

    return new Entrepreneurship.fromMap(profile as dynamic);
  }
}
