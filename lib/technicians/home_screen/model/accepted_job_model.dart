// To parse this JSON data, do
//
//     final acceptedJobModel = acceptedJobModelFromJson(jsonString);

import 'dart:convert';

AcceptedJobModel acceptedJobModelFromJson(String str) => AcceptedJobModel.fromJson(json.decode(str) as Map<String,dynamic>);

String acceptedJobModelToJson(AcceptedJobModel data) => json.encode(data.toJson());

class AcceptedJobModel {

    AcceptedJobModel({
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

    factory AcceptedJobModel.fromJson(Map<String, dynamic> json) => AcceptedJobModel(
        client: json['client'] == null ? null : Client.fromJson(json['client'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String) ,
        uuid: json['uuid'] as String,
        name: json['name']as String,
        description: json['description']as String,
        image: json['image'] as dynamic,
        locationAddress: json['locationAddress'] as String,
        status: json['status'] as String,
        locationLongitude: json['locationLongitude']?.toDouble() as double,
        locationLatitude: json['locationLatitude']?.toDouble() as double,
        duration: json['duration'] as int,
        minPriceCurrency: json['minPriceCurrency']as String,
        minPrice: json['minPrice']as String,
        maxPriceCurrency: json['maxPriceCurrency'] as String,
        maxPrice: json['maxPrice']as String,
        requireTechniciansImmediately: json['requireTechniciansImmediately'] as bool,
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

    AcceptedJobModel copyWith({
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
        AcceptedJobModel(
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
            requireTechniciansImmediately: requireTechniciansImmediately ?? this.requireTechniciansImmediately,
            requireTechniciansNextDay: requireTechniciansNextDay ?? this.requireTechniciansNextDay,
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
}

class Client {

    Client({
        this.user,
        this.uuid,
        this.accountType,
        this.address,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        user: json['user'] == null ? null : User.fromJson(json['user'] as Map<String,dynamic>),
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
