import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'dart:convert';

class CategoriesService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, String> categories = {};
  late CollectionReference _categories;

  bool isLoading = false;

  CategoriesService() {
    this._categories = _firestore.collection('category');
    print("Entró:");
    this.loadCategories();
    print("Salió:");
  }

  Future loadCategories() async {
    print("------------");
    print("Inicializo busqueda de categorías.");
    var resp = await _categories
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.forEach((doc) {
              var name = (doc.data() as dynamic)["name_category"];
              var icon = (doc.data() as dynamic)["icon_name"];
              categories[name] = icon;
              print(name);
            }));

    print("------------");
    print("Terminó busqueda de categorías.");
  }
}
