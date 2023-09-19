import 'dart:convert';

import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RegisterProvider extends ChangeNotifier {
  String endpoint = 'https://identitytoolkit.googleapis.com/v1/';
  RegisterProvider() {
    // ignore: avoid_print
    print('Inciando register_provider...');
  }

  Future<bool> registrarUsuario(Map<String, String> formData) async {
    var url = Uri.parse('${endpoint}accounts:signUp?key=AIzaSyCovgZ8JoKP9wmKBFQzO6g3OuitSvaTj84');

    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      var usuario = User.fromJson(jsonDecode(response.body));
      // ignore: avoid_print
      print(usuario.localId);
      var urlDb = Uri.parse(
          'https://bootcamp-6fd74-default-rtdb.firebaseio.com/users/${usuario.localId!}.json');
      var responseDb = await http.put(urlDb,
          body: jsonEncode(
              {'name': formData['name'], 'lastname': formData['lastname']}));
      if (responseDb.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
