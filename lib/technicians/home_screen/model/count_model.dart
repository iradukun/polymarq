// To parse this JSON data, do
//
//     final countModel = countModelFromJson(jsonString);

import 'dart:convert';

CountModel countModelFromJson(String str) =>
    CountModel.fromJson(json.decode(str) as Map<String, dynamic>);

String countModelToJson(CountModel data) => json.encode(data.toJson());

class CountModel {

  CountModel({
    this.count,
  });

  factory CountModel.fromJson(Map<String, dynamic> json) => CountModel(
        count: json['count'] as int,
      );
  int? count;

  CountModel copyWith({
    int? count,
  }) =>
      CountModel(
        count: count ?? this.count,
      );

  Map<String, dynamic> toJson() => {
        'count': count,
      };

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
