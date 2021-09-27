import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ecoshops/models/user.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _users;
  late Account currentUser;

  AuthService() {
    init();
    this.currentUser = new Account(
        birthDate: DateTime.now(), mail: '', password: '', role: 'c');
    this._users = _firestore.collection('user');
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future createAccount(BuildContext context) async {
    try {
      // Save user in auth system
      UserCredential resp = await _auth.createUserWithEmailAndPassword(
          email: currentUser.mail, password: currentUser.password);
      var user = resp.user;
      print("-----------------------------");
      print(user!.uid);
      print("-----------------------------");

      // Save user in data base
      DocumentReference docRef = _users.doc(user.uid);
      print(currentUser.toMap());
      await docRef
          .set(currentUser.toMap())
          .whenComplete(() => print("Usuario agregado a la base de datos."))
          .catchError((e) => print(e));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future signIn(BuildContext context) async {
    try {
      UserCredential resp = await _auth.signInWithEmailAndPassword(
          email: currentUser.mail, password: currentUser.password);
      var user = resp.user;

      var snap = await _users.doc(user!.uid).get();
      print(snap.data());
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future signOut() async {
    this.currentUser = new Account(
        birthDate: DateTime.now(), mail: '', password: '', role: 'c');
    await _auth.signOut();
  }
}
