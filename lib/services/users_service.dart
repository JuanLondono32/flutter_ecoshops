/*
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersService extends ChangeNotifier {
  final String _baseUrl = 'ecoshops-1338f-default-rtdb.firebaseio.com';
  late User currentUser;

  bool isLoading = true;
  bool isSaving = false;

  UsersService() {
    this.currentUser =
        new User(birthDate: DateTime.now(), mail: "", password: "");
  }

  /*
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
  */

  Future<String> createUser() async {
    final url = Uri.https(_baseUrl, 'user.json');
    final resp = await http.post(url, body: currentUser.toJson());

    print('Respuesta del servidor: $resp');
    this.currentUser =
        new User(birthDate: DateTime.now(), mail: "", password: "");

    return "";
  }

  Future<String> deleteUser(User user) async {
    final url = Uri.https(_baseUrl, 'user/${user.id}.json');
    final resp = await http.delete(url, body: user.toJson());

    return "";
  }

  Future<bool> verifyUser() async {
    final url = Uri.https(_baseUrl, 'user.json');
    final resp = await http.get(url);
    bool match = false;

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      final tempUser = User.fromMap(value);
      if (currentUser.mail == tempUser.mail) {
        if (currentUser.password == tempUser.password) {
          //this.currentUser = tempUser;
          match = true;
        }
      }
    });

    return match;
  }
}
*/
