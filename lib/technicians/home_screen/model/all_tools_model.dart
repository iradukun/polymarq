// To parse this JSON data, do
//
//     final allToolsModel = allToolsModelFromJson(jsonString);

import 'dart:convert';

AllToolsModel allToolsModelFromJson(String str) =>
    AllToolsModel.fromJson(json.decode(str) as Map<String, dynamic>);

String allToolsModelToJson(AllToolsModel data) => json.encode(data.toJson());

class AllToolsModel {
  AllToolsModel({
    this.owner,
    this.category,
    this.images,
    this.colorCodes,
    this.uuid,
    this.name,
    this.description,
    this.negotiable,
    this.pricingPeriod,
    this.priceCurrency,
    this.price,
    this.isRented,
    this.isAvailable,
    
  });

  factory AllToolsModel.fromJson(Map<String, dynamic> json) => AllToolsModel(
        owner: json['owner'] == null
            ? null
            : Owner.fromJson(json['owner'] as Map<String, dynamic>),
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
        images: List<Image>.from((json['images'] as List<dynamic>)
            .map((x) => Image.fromJson(x as Map<String, dynamic>)),),
      colorCodes: json['colorCodes'] == null ? [] : List<String>.
            from(json['colorCodes']!.map((x) => x )as Iterable<dynamic>,
            ),
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
  Category? category;
  List<Image>? images;
   List<String>? colorCodes;
  String? uuid;
  String? name;
  String? description;
  bool? negotiable;
  String? pricingPeriod;
  String? priceCurrency;
  String? price;
  bool? isRented;
  bool? isAvailable;

  AllToolsModel copyWith({
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
      AllToolsModel(
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
        'owner': owner?.toJson(),
        'category': category?.toJson(),
        'images': images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
             'colorCodes': colorCodes == null ? [] : List<dynamic>.
             from(colorCodes!.map((x) => x)),
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
    this.uuid,
    this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        uuid: json['uuid'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
      );
  String? uuid;
  String? name;
  String? description;

  Category copyWith({
    String? uuid,
    String? name,
    String? description,
  }) =>
      Category(
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'name': name,
        'description': description,
      };
}

class Image {
  Image({
    this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        image: json['image'] as String,
      );
  String? image;

  Image copyWith({
    String? image,
  }) =>
      Image(
        image: image ?? this.image,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
      };
}

class Owner {

  Owner({
    this.user,
    
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

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),

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
  
  String? uuid;
  String? professionalSummary;
  String? country;
  String? city;
  String? localGovernmentArea;
  String? workAddress;
  String? services;
  int? yearsOfExperience;
  dynamic jobTitle;

  Owner copyWith({
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
      Owner(
        user: user ?? this.user,
       
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
    this.longitude,
    this.latitude,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'] == null ? null : json['username'] as String,
        firstName:
            json['firstName'] == null ? null : json['firstName'] as String,
        lastName: json['lastName'] == null ? null : json['lastName'] as String,
        longitude:
            json['longitude'] == null ? null : json['longitude'] as double,
        latitude: json['latitude'] == null ? null : json['latitude'] as double,
      );
  String? username;
  String? firstName;
  String? lastName;
  dynamic longitude;
  dynamic latitude;

  User copyWith({
    String? username,
    String? firstName,
    String? lastName,
    dynamic longitude,
    dynamic latitude,
  }) =>
      User(
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'longitude': longitude,
        'latitude': latitude,
      };
}
