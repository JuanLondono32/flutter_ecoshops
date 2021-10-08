import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'dart:convert';

class CategoriesService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _categories;

  bool isLoading = false;

  CategoriesService() {
    this._categories = _firestore.collection('category');
    this.loadCategories();
  }

  Future loadCategories() async {
    this.isLoading = true;
    notifyListeners();

    var docs;

    var snap = await _categories.get();
    snap.docs;

    print("---------------");
    print(snap);
    print(snap.toString());
    print("---------------");

    this.isLoading = false;
    notifyListeners();
  }
}
