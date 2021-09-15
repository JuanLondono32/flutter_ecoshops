import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesService extends ChangeNotifier {
  final String _baseUrl = 'ecoshops-1338f-default-rtdb.firebaseio.com';
  //final List<Category> categories = [];
  final Map<String, String> cat2Id = {};
  final Map<String, String> id2Cat = {};

  bool isLoading = true;
  bool isSaving = false;

  CategoriesService() {
    this.loadCategories();
  }

  Future loadCategories() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'category.json');
    final resp = await http.get(url);

    final Map<String, dynamic> categoriesMap = json.decode(resp.body);

    categoriesMap.forEach((key, value) {
      final name = Category.fromMap(value).nameCategory;
      cat2Id[name] = key;
      id2Cat[key] = name;
    });

    this.isLoading = false;
    notifyListeners();
  }
}
