import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersService extends ChangeNotifier {
  final String _baseUrl = 'ecoshops-1338f-default-rtdb.firebaseio.com';
  late User user;

  bool isLoading = true;
  bool isSaving = false;

  Future saveOrCreateUser(User user) async {
    isSaving = true;
    notifyListeners();

    if (user.id == null) {
      // Es necesario crear
      await this.createUser(user);
    } else {
      // Actualizar
      await this.createUser(user);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateUser(User user) async {
    final url = Uri.https(_baseUrl, 'user/${user.id}.json');
    final resp = await http.put(url, body: user.toJson());
    //final decodedData = resp.body;

    return "";
  }

  Future<String> createUser(User user) async {
    final url = Uri.https(_baseUrl, 'user.json');
    final resp = await http.post(url, body: user.toJson());

    return "";
  }

  Future<String> deleteUser(User user) async {
    final url = Uri.https(_baseUrl, 'user/${user.id}.json');
    final resp = await http.delete(url, body: user.toJson());

    return "";
  }

  Future<bool> verifyUser(User user) async {
    final url = Uri.https(_baseUrl, 'user.json');
    final resp = await http.get(url);
    bool match = false;

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      final tempUser = User.fromMap(value);
      if (user.mail == tempUser.mail) {
        if (user.password == tempUser.password) {
          match = true;
        }
      }
    });

    return match;
  }
}
