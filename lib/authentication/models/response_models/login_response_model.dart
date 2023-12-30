// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));
String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());
class LoginResponseModel {
  LoginResponseModel({
      this.user, 
      this.tokens,});

  LoginResponseModel.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }
  User? user;
  Tokens? tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (tokens != null) {
      map['tokens'] = tokens?.toJson();
    }
    return map;
  }

}

Tokens tokensFromJson(String str) => Tokens.fromJson(json.decode(str));
String tokensToJson(Tokens data) => json.encode(data.toJson());
class Tokens {
  Tokens({
      this.refresh, 
      this.access,});

  Tokens.fromJson(dynamic json) {
    refresh = json['refresh'] as String?;
    access = json['access'] as String?;
  }
  String? refresh;
  String? access;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = refresh;
    map['access'] = access;
    return map;
  }

}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      this.username, 
      this.firstName, 
      this.lastName, 
      this.uuid, 
      this.email, 
      this.phoneNumber, 
      this.longitude, 
      this.latitude,
      this.profilePicture,
  });

  User.fromJson(dynamic json) {
    username = json['username'] as String?;
    firstName = json['firstName'] as String?;
    lastName = json['lastName'] as String?;
    uuid = json['uuid'] as String?;
    email = json['email'] as String?;
    phoneNumber = json['phoneNumber'] as String?;
    longitude = json['longitude'];
    latitude = json['latitude'];
    profilePicture = json['profilePicture'] as String?;
  }
  String? username;
  String? firstName;
  String? lastName;
  String? uuid;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  dynamic longitude;
  dynamic latitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['uuid'] = uuid;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['profilePicture'] = profilePicture;
    return map;
  }

  User copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? uuid,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    dynamic longitude,
    dynamic latitude,
  }) {
    return User(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      uuid: uuid ?? this.uuid,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
