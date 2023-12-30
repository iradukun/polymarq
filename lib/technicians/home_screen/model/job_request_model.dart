// To parse this JSON data, do
//
//     final jobRequestModel = jobRequestModelFromJson(jsonString);

import 'dart:convert';

JobRequestModel jobRequestModelFromJson(String str) =>
    JobRequestModel.fromJson(json.decode(str) as Map<String, dynamic>);

String jobRequestModelToJson(JobRequestModel data) =>
    json.encode(data.toJson());

class JobRequestModel {

  JobRequestModel({
    this.job,
    this.createdAt,
    this.updatedAt,
    this.uuid,
    this.distanceFromClient,
    this.status,
    this.priceQuoteCurrency,
    this.priceQuote,
    this.transactionCostCurrency,
    this.transactionCost,
    this.technician,
    this.client,
  });

  factory JobRequestModel.fromJson(Map<String, dynamic> json) =>
      JobRequestModel(
        job: json['job'] == null
            ? null
            : Job.fromJson(json['job'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        uuid: json['uuid'] as String,
        distanceFromClient: json['distanceFromClient'] as num,
        status: json['status'] as String,
        priceQuoteCurrency: json['priceQuoteCurrency'] as String,
        priceQuote: json['priceQuote'] as String,
        transactionCostCurrency: json['transactionCostCurrency'] as String,
        transactionCost: json['transactionCost'] as String,
        technician: json['technician'] as int,
        client: json['client'] as int,
      );
  Job? job;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? uuid;
  num? distanceFromClient;
  String? status;
  String? priceQuoteCurrency;
  String? priceQuote;
  String? transactionCostCurrency;
  String? transactionCost;
  int? technician;
  int? client;

  JobRequestModel copyWith({
    Job? job,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? uuid,
    num? distanceFromClient,
    String? status,
    String? priceQuoteCurrency,
    String? priceQuote,
    String? transactionCostCurrency,
    String? transactionCost,
    int? technician,
    int? client,
  }) =>
      JobRequestModel(
        job: job ?? this.job,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        uuid: uuid ?? this.uuid,
        distanceFromClient: distanceFromClient ?? this.distanceFromClient,
        status: status ?? this.status,
        priceQuoteCurrency: priceQuoteCurrency ?? this.priceQuoteCurrency,
        priceQuote: priceQuote ?? this.priceQuote,
        transactionCostCurrency:
            transactionCostCurrency ?? this.transactionCostCurrency,
        transactionCost: transactionCost ?? this.transactionCost,
        technician: technician ?? this.technician,
        client: client ?? this.client,
      );

  Map<String, dynamic> toJson() => {
        'job': job?.toJson(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'uuid': uuid,
        'distanceFromClient': distanceFromClient,
        'status': status,
        'priceQuoteCurrency': priceQuoteCurrency,
        'priceQuote': priceQuote,
        'transactionCostCurrency': transactionCostCurrency,
        'transactionCost': transactionCost,
        'technician': technician,
        'client': client,
      };
  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}

class Job {

  Job({
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
    this.requireTechniciansImmediately,
    this.requireTechniciansNextDay,
    this.completionState,
    this.pingRequestCycle,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        client: json['client'] == null
            ? null
            : Client.fromJson(json['client'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        uuid: json['uuid'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        image: json['image'] as dynamic,
        locationAddress: json['locationAddress'] as String,
        status: json['status'] as String,
        locationLongitude: json['locationLongitude']?.toDouble() as double,
        locationLatitude: json['locationLatitude']?.toDouble() as double,
        duration: json['duration'] as int,
        minPriceCurrency: json['minPriceCurrency'] as String,
        minPrice: json['minPrice'] as String,
        maxPriceCurrency: json['maxPriceCurrency'] as String,
        maxPrice: json['maxPrice'] as String,
        requireTechniciansImmediately:
            json['requireTechniciansImmediately'] as bool,
        requireTechniciansNextDay: json['requireTechniciansNextDay'] as bool,
        completionState: json['completionState'] as String,
        pingRequestCycle: json['pingRequestCycle'] as int,
      );
  Client? client;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? uuid;
  String? name;
  String? description;
  dynamic image;
  String? locationAddress;
  String? status;
  double? locationLongitude;
  double? locationLatitude;
  int? duration;
  String? minPriceCurrency;
  String? minPrice;
  String? maxPriceCurrency;
  String? maxPrice;
  bool? requireTechniciansImmediately;
  bool? requireTechniciansNextDay;
  String? completionState;
  int? pingRequestCycle;

  Job copyWith({
    Client? client,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? uuid,
    String? name,
    String? description,
    dynamic image,
    String? locationAddress,
    String? status,
    double? locationLongitude,
    double? locationLatitude,
    int? duration,
    String? minPriceCurrency,
    String? minPrice,
    String? maxPriceCurrency,
    String? maxPrice,
    bool? requireTechniciansImmediately,
    bool? requireTechniciansNextDay,
    String? completionState,
    int? pingRequestCycle,
  }) =>
      Job(
        client: client ?? this.client,
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
        requireTechniciansImmediately:
            requireTechniciansImmediately ?? this.requireTechniciansImmediately,
        requireTechniciansNextDay:
            requireTechniciansNextDay ?? this.requireTechniciansNextDay,
        completionState: completionState ?? this.completionState,
        pingRequestCycle: pingRequestCycle ?? this.pingRequestCycle,
      );

  Map<String, dynamic> toJson() => {
        'client': client?.toJson(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'uuid': uuid,
        'name': name,
        'description': description,
        'image': image,
        'locationAddress': locationAddress,
        'status': status,
        'locationLongitude': locationLongitude,
        'locationLatitude': locationLatitude,
        'duration': duration,
        'minPriceCurrency': minPriceCurrency,
        'minPrice': minPrice,
        'maxPriceCurrency': maxPriceCurrency,
        'maxPrice': maxPrice,
        'requireTechniciansImmediately': requireTechniciansImmediately,
        'requireTechniciansNextDay': requireTechniciansNextDay,
        'completionState': completionState,
        'pingRequestCycle': pingRequestCycle,
      };
  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}

class Client {

  Client({
    this.user,
    this.uuid,
    this.accountType,
    this.address,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        uuid: json['uuid'] as String,
        accountType: json['accountType'] as String,
        address: json['address'] as String,
      );
  User? user;
  String? uuid;
  String? accountType;
  String? address;

  Client copyWith({
    User? user,
    String? uuid,
    String? accountType,
    String? address,
  }) =>
      Client(
        user: user ?? this.user,
        uuid: uuid ?? this.uuid,
        accountType: accountType ?? this.accountType,
        address: address ?? this.address,
      );

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'uuid': uuid,
        'accountType': accountType,
        'address': address,
      };
  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
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
        longitude: json['longitude'] as dynamic,
        latitude: json['latitude'] as dynamic,
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
  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
