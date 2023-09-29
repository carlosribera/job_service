import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/user.dart';

import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  String endpoint = 'https://identitytoolkit.googleapis.com/v1/';
  User user = User();

  setUser(User _user) {
    user = _user;
    notifyListeners();
  }

  setUserLocation(double latitude, double longitude){
    user.setLocation(latitude,longitude);
    notifyListeners();
  }

  Future<bool> updateUsuario(Map<String, String> formData) async {
    var urlDb = Uri.parse(
        'https://job-service-9ba62-default-rtdb.firebaseio.com/users/${formData['localId']!}.json');
    var responseDb = await http.put(urlDb, body: jsonEncode(formData));
    if (responseDb.statusCode == 200) {
      user.setUserData(jsonDecode(responseDb.body));
      notifyListeners();
      return true;
    }
    return false;
  }
}
