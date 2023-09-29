// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.kind,
    this.idToken,
    this.email,
    this.refreshToken,
    this.expiresIn,
    this.localId,
  });

  String? kind;
  String? idToken;
  String? email;
  String? refreshToken;
  String? expiresIn;
  String? localId;
  String? name;
  String? lastname;
  String? image;
  double? latitude = 100;
  double? longitude = 100;

  factory User.fromJson(Map<String, dynamic> json) => User(
        kind: json["kind"],
        idToken: json["idToken"],
        email: json["email"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        localId: json["localId"],
      );

  setUserData(Map<String, dynamic> json) {
    name = json['name'];
    lastname = json['lastname'];
    image = json['image'];
    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
  }

  setLocation(double latitude, double longitude){
    this.latitude = latitude;
    this.longitude = longitude;
  }

  Map<String, String> toJson() => {
        "localId": localId!,
        "latitude": latitude!.toString(),
        "longitude": longitude!.toString(),
        "name": name!,
        "lastname": lastname!,
        "image": image!,
      };
}
