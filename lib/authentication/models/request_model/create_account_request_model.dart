// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
CreateAccountRequestModel createAccountRequestModelFromJson(String str) => CreateAccountRequestModel.fromJson(json.decode(str));
String createAccountRequestModelToJson(CreateAccountRequestModel data) => json.encode(data.toJson());
class CreateAccountRequestModel {
  CreateAccountRequestModel({
      this.user, 
      this.certificate, 
      this.professionalSummary, 
      this.country, 
      this.city, 
      this.localGovernmentArea, 
      this.workAddress, 
      this.services, 
      this.yearsOfExperience, 
      this.jobTitle,});

  CreateAccountRequestModel.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    certificate = json['certificate'] as String?;
    professionalSummary = json['professional_summary'] as String?;
    country = json['country'] as String?;
    city = json['city'] as String?;
    localGovernmentArea = json['local_government_area'] as String?;
    workAddress = json['work_address'] as String?;
    services = json['services'] as String?;
    yearsOfExperience = json['years_of_experience'] as num?;
    jobTitle = json['job_title'] as num?;
  }
  User? user;
  String? certificate;
  String? professionalSummary;
  String? country;
  String? city;
  String? localGovernmentArea;
  String? workAddress;
  String? services;
  num? yearsOfExperience;
  num? jobTitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['certificate'] = certificate;
    map['professional_summary'] = professionalSummary;
    map['country'] = country;
    map['city'] = city;
    map['local_government_area'] = localGovernmentArea;
    map['work_address'] = workAddress;
    map['services'] = services;
    map['years_of_experience'] = yearsOfExperience;
    map['job_title'] = jobTitle;
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      this.email, 
      this.firstName, 
      this.lastName, 
      this.password, 
      this.phoneNumber, 
      this.longitude, 
      this.latitude,});

  User.fromJson(dynamic json) {
    email = json['email'] as String?;
    firstName = json['first_name'] as String?;
    lastName = json['last_name'] as String?;
    password = json['password'] as String?;
    phoneNumber = json['phone_number'] as String?;
    longitude = json['longitude'] as num?;
    latitude = json['latitude'] as num?;
  }
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? phoneNumber;
  num? longitude;
  num? latitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['password'] = password;
    map['phone_number'] = phoneNumber;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    return map;
  }
}
