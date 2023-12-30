// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str) as Map<String, dynamic>);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {

  UserModel({
    this.user,
    this.certificates,
    this.uuid,
    this.professionalSummary,
    this.country,
    this.city,
    this.localGovernmentArea,
    this.workAddress,
    this.services,
    this.yearsOfExperience,
    this.jobTitle,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        certificates: json['certificates'] == null
            ? []
            : List<dynamic>.from(
                json['certificates']!.map((x) => x) as Iterable<dynamic>,),
        uuid: json['uuid'] as String,
        professionalSummary: json['professionalSummary'] as String,
        country: json['country'] as String,
        city: json['city'] as String,
        localGovernmentArea: json['localGovernmentArea'] as String,
        workAddress: json['workAddress'] as String,
        services: json['services'] as String,
        yearsOfExperience: json['yearsOfExperience'] as int,
        jobTitle: json['jobTitle'] as dynamic,
      );
  User? user;
  List<dynamic>? certificates;
  String? uuid;
  String? professionalSummary;
  String? country;
  String? city;
  String? localGovernmentArea;
  String? workAddress;
  String? services;
  int? yearsOfExperience;
  dynamic jobTitle;

  UserModel copyWith({
    User? user,
    List<dynamic>? certificates,
    String? uuid,
    String? professionalSummary,
    String? country,
    String? city,
    String? localGovernmentArea,
    String? workAddress,
    String? services,
    int? yearsOfExperience,
    dynamic jobTitle,
  }) =>
      UserModel(
        user: user ?? this.user,
        certificates: certificates ?? this.certificates,
        uuid: uuid ?? this.uuid,
        professionalSummary: professionalSummary ?? this.professionalSummary,
        country: country ?? this.country,
        city: city ?? this.city,
        localGovernmentArea: localGovernmentArea ?? this.localGovernmentArea,
        workAddress: workAddress ?? this.workAddress,
        services: services ?? this.services,
        yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
        jobTitle: jobTitle ?? this.jobTitle,
      );

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'certificates': certificates == null
            ? []
            : List<dynamic>.from(certificates!.map((x) => x)),
        'uuid': uuid,
        'professionalSummary': professionalSummary,
        'country': country,
        'city': city,
        'localGovernmentArea': localGovernmentArea,
        'workAddress': workAddress,
        'services': services,
        'yearsOfExperience': yearsOfExperience,
        'jobTitle': jobTitle,
      };
}

class User {

  User({
    this.username,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.longitude,
    this.latitude,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profilePicture: json['profilePicture'] as dynamic,
        longitude: json['longitude']?.toDouble() as dynamic,
        latitude: json['latitude']?.toDouble() as dynamic,
      );
  String? username;
  String? firstName;
  String? lastName;
  dynamic profilePicture;
  dynamic longitude;
  dynamic latitude;

  User copyWith({
    String? username,
    String? firstName,
    String? lastName,
    dynamic profilePicture,
    dynamic longitude,
    dynamic latitude,
  }) =>
      User(
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        profilePicture: profilePicture ?? this.profilePicture,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'profilePicture': profilePicture,
        'longitude': longitude,
        'latitude': latitude,
      };
}
