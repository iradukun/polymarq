// To parse this JSON data, do
//
//     final tool = toolFromJson(jsonString);

import 'dart:convert';

Tool toolFromJson(String str) =>
    Tool.fromJson(json.decode(str) as Map<String, dynamic>);

String toolToJson(Tool data) => json.encode(data.toJson());

class Tool {
  Tool({
    required this.owner,
    required this.category,
    required this.images,
    required this.uuid, required this.name,
     required this.description, required this.negotiable, 
     required this.pricingPeriod, required this.priceCurrency, 
     required this.price, required this.isRented, 
     required this.isAvailable, this.colorCodes,
    this.condition,
  });

  factory Tool.fromJson(Map<String, dynamic> json) => Tool(
        owner: json['owner'] == null
            ? null
            : Owner.fromJson(json['owner'] as Map<String, dynamic>),
        category: Category.fromJson(json['category'] as Map<String, dynamic>),
        images: List<Image>.from(
          (json['images'] as List<dynamic>)
              .map((x) => Image.fromJson(x as Map<String, dynamic>)),
        ),
        colorCodes: json['colorCodes'] == null
            ? []
            : List<String>.from(json['colorCodes'] as List<dynamic>),
        condition: json['condition'] as String,
        uuid: json['uuid'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        negotiable: json['negotiable'] as bool,
        pricingPeriod: json['pricingPeriod'] as String,
        priceCurrency: json['priceCurrency'] as String,
        price: json['price'] as String,
        isRented: json['isRented'] as bool,
        isAvailable: json['isAvailable'] as bool,
      );
  Owner? owner;
  Category category;
  List<Image> images;
  List<String>? colorCodes;
  String? condition;
  String uuid;
  String name;
  String description;
  bool negotiable;
  String pricingPeriod;
  String priceCurrency;
  String price;
  bool isRented;
  bool isAvailable;
  Tool copyWith({
    Owner? owner,
    Category? category,
    List<Image>? images,
    List<String>? colorCodes,
    String? uuid,
    String? name,
    String? description,
    bool? negotiable,
    String? pricingPeriod,
    String? priceCurrency,
    String? price,
    bool? isRented,
    bool? isAvailable,
  }) =>
      Tool(
        owner: owner ?? this.owner,
        category: category ?? this.category,
        colorCodes: colorCodes ?? this.colorCodes,
        images: images ?? this.images,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        description: description ?? this.description,
        negotiable: negotiable ?? this.negotiable,
        pricingPeriod: pricingPeriod ?? this.pricingPeriod,
        priceCurrency: priceCurrency ?? this.priceCurrency,
        price: price ?? this.price,
        isRented: isRented ?? this.isRented,
        isAvailable: isAvailable ?? this.isAvailable,
      );

  Map<String, dynamic> toJson() => {
        'owner': owner == null ? null : owner!.toJson(),
        'category': category.toJson(),
        'images': List<dynamic>.from(images.map((x) => x.toJson())),
        'colorCodes': colorCodes == null
            ? []
            : List<dynamic>.from(colorCodes!.map((x) => x)),
        'uuid': uuid,
        'name': name,
        'description': description,
        'negotiable': negotiable,
        'pricingPeriod': pricingPeriod,
        'priceCurrency': priceCurrency,
        'price': price,
        'isRented': isRented,
        'isAvailable': isAvailable,
      };
}

class Category {
  Category({
    required this.uuid,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        uuid: json['uuid'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
      );
  String uuid;
  String name;
  String description;

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'name': name,
        'description': description,
      };
}

class Image {
  Image({
    required this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        image: json['image'] as String,
      );
  String image;

  Map<String, dynamic> toJson() => {
        'image': image,
      };
}

class Owner {
  Owner({
    required this.user,
    required this.certificates,
    required this.uuid,
    required this.professionalSummary,
    required this.country,
    required this.city,
    required this.localGovernmentArea,
    required this.workAddress,
    required this.services,
    required this.yearsOfExperience,
    required this.jobTitle,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        user: User.fromJson(json['user'] as Map<String, dynamic>),
        certificates: List<dynamic>.from(json['certificates'] as List),
        uuid: json['uuid'] as String,
        professionalSummary: json['professionalSummary'] as String,
        country: json['country'] as String,
        city: json['city'] as String,
        localGovernmentArea: json['localGovernmentArea'] as String,
        workAddress: json['workAddress'] as String,
        services: json['services'] as String,
        yearsOfExperience: json['yearsOfExperience'] as int,
        jobTitle: json['jobTitle'],
      );
  User user;
  List<dynamic> certificates;
  String uuid;
  String professionalSummary;
  String country;
  String city;
  String localGovernmentArea;
  String workAddress;
  String services;
  int yearsOfExperience;
  dynamic jobTitle;

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'certificates': List<dynamic>.from(certificates.map((x) => x)),
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
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.longitude,
    required this.latitude,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        longitude: json['longitude'],
        latitude: json['latitude'],
      );
  String username;
  String firstName;
  String lastName;
  dynamic longitude;
  dynamic latitude;

  Map<String, dynamic> toJson() => {
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'longitude': longitude,
        'latitude': latitude,
      };
}
