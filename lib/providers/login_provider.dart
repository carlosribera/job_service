import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;


class LoginProvider extends ChangeNotifier {
  String endpoint = 'https://identitytoolkit.googleapis.com/v1/';
  LoginProvider() {
    // ignore: avoid_print
    print('Inciando login_provider...');
  }

  Future<User?> loginUsuario(Map<String, String> formData) async {
    var url = Uri.parse(
        '${endpoint}accounts:signInWithPassword?key=AIzaSyCypczv1dQwnk50LwiKaBaEZnSj9Nry6Ek');

    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      var usuario = User.fromJson(jsonDecode(response.body));
      var urlDb = Uri.parse(
          'https://job-service-9ba62-default-rtdb.firebaseio.com/users/${usuario.localId}.json');
      var responseDb = await http.get(urlDb);
      if (responseDb.statusCode == 200) {
        usuario.setUserData(jsonDecode(responseDb.body));
        return usuario;
      }
    }
    return null;
  }
}