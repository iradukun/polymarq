// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

String jobListModelToJson(JobListModel data) => json.encode(data.toJson());
class JobListModel {
  JobListModel({
      this.data, 
      this.count,});

  JobListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    count = json['count'] as num?;
  }
  List<Data>? data;
  num? count;
JobListModel copyWith({  List<Data>? data,
  num? count,
}) => JobListModel(  data: data ?? this.data,
  count: count ?? this.count,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.client, 
      this.createdAt, 
      this.updatedAt, 
      this.uuid, 
      this.name, 
      this.description, 
      this.image, 
      this.locationAddress, 
      this.status, 
      this.locationLongitude, 
      this.locationLatitude, 
      this.duration, 
      this.minPriceCurrency, 
      this.minPrice, 
      this.maxPriceCurrency, 
      this.maxPrice, 
      this.requireTechniciansImmediately,});

  Data.fromJson(dynamic json) {
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    uuid = json['uuid'] as String?;
    name = json['name'] as String?;
    description = json['description'] as String?;
    image = json['image'] as dynamic;
    locationAddress = json['locationAddress'] as String?;
    status = json['status'] as String?;
    locationLongitude = json['locationLongitude'] as num?;
    locationLatitude = json['locationLatitude'] as num?;
    duration = json['duration'] as num?;
    minPriceCurrency = json['minPriceCurrency'] as String?;
    minPrice = json['minPrice'] as String?;
    maxPriceCurrency = json['maxPriceCurrency'] as String?;
    maxPrice = json['maxPrice'] as String?;
    requireTechniciansImmediately = json['requireTechniciansImmediately'] as bool?;
  }
  Client? client;
  String? createdAt;
  String? updatedAt;
  String? uuid;
  String? name;
  String? description;
  dynamic image;
  String? locationAddress;
  String? status;
  num? locationLongitude;
  num? locationLatitude;
  num? duration;
  String? minPriceCurrency;
  String? minPrice;
  String? maxPriceCurrency;
  String? maxPrice;
  bool? requireTechniciansImmediately;
Data copyWith({  Client? client,
  String? createdAt,
  String? updatedAt,
  String? uuid,
  String? name,
  String? description,
  dynamic image,
  String? locationAddress,
  String? status,
  num? locationLongitude,
  num? locationLatitude,
  num? duration,
  String? minPriceCurrency,
  String? minPrice,
  String? maxPriceCurrency,
  String? maxPrice,
  bool? requireTechniciansImmediately,
}) => Data(  client: client ?? this.client,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  uuid: uuid ?? this.uuid,
  name: name ?? this.name,
  description: description ?? this.description,
  image: image ?? this.image,
  locationAddress: locationAddress ?? this.locationAddress,
  status: status ?? this.status,
  locationLongitude: locationLongitude ?? this.locationLongitude,
  locationLatitude: locationLatitude ?? this.locationLatitude,
  duration: duration ?? this.duration,
  minPriceCurrency: minPriceCurrency ?? this.minPriceCurrency,
  minPrice: minPrice ?? this.minPrice,
  maxPriceCurrency: maxPriceCurrency ?? this.maxPriceCurrency,
  maxPrice: maxPrice ?? this.maxPrice,
  requireTechniciansImmediately: requireTechniciansImmediately ?? this.requireTechniciansImmediately,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (client != null) {
      map['client'] = client?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['uuid'] = uuid;
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['locationAddress'] = locationAddress;
    map['status'] = status;
    map['locationLongitude'] = locationLongitude;
    map['locationLatitude'] = locationLatitude;
    map['duration'] = duration;
    map['minPriceCurrency'] = minPriceCurrency;
    map['minPrice'] = minPrice;
    map['maxPriceCurrency'] = maxPriceCurrency;
    map['maxPrice'] = maxPrice;
    map['requireTechniciansImmediately'] = requireTechniciansImmediately;
    return map;
  }

}

Client clientFromJson(String str) => Client.fromJson(json.decode(str));
String clientToJson(Client data) => json.encode(data.toJson());
class Client {
  Client({
      this.user, 
      this.uuid, 
      this.accountType, 
      this.address,});

  Client.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    uuid = json['uuid'] as String?;
    accountType = json['accountType'] as String?;
    address = json['address'] as String?;
  }
  User? user;
  String? uuid;
  String? accountType;
  String? address;
Client copyWith({  User? user,
  String? uuid,
  String? accountType,
  String? address,
}) => Client(  user: user ?? this.user,
  uuid: uuid ?? this.uuid,
  accountType: accountType ?? this.accountType,
  address: address ?? this.address,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['uuid'] = uuid;
    map['accountType'] = accountType;
    map['address'] = address;
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
      this.longitude, 
      this.latitude,});

  User.fromJson(dynamic json) {
    username = json['username'] as String?;
    firstName = json['firstName'] as String?;
    lastName = json['lastName'] as String?;
    longitude = json['longitude'] as dynamic;
    latitude = json['latitude'] as dynamic;
  }
  String? username;
  String? firstName;
  String? lastName;
  dynamic longitude;
  dynamic latitude;
User copyWith({  String? username,
  String? firstName,
  String? lastName,
  dynamic longitude,
  dynamic latitude,
}) => User(  username: username ?? this.username,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  longitude: longitude ?? this.longitude,
  latitude: latitude ?? this.latitude,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    return map;
  }

}
