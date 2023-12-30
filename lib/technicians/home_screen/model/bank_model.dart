// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) =>
    BankModel.fromJson(json.decode(str) as Map<String, dynamic>);

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {

  BankModel({
    this.name,
    this.slug,
    this.code,
    this.longcode,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        name: json['name'] as String,
        slug: json['slug'] as String,
        code: json['code'] as String,
        longcode: json['longcode'] as String,
      );
  String? name;
  String? slug;
  String? code;
  String? longcode;

  BankModel copyWith({
    String? name,
    String? slug,
    String? code,
    String? longcode,
  }) =>
      BankModel(
        name: name ?? this.name,
        slug: slug ?? this.slug,
        code: code ?? this.code,
        longcode: longcode ?? this.longcode,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'code': code,
        'longcode': longcode,
      };
}
