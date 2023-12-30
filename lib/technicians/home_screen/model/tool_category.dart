// To parse this JSON data, do
//
//     final toolCategory = toolCategoryFromJson(jsonString);

import 'dart:convert';

ToolCategory toolCategoryFromJson(String str) => ToolCategory.fromJson(json.decode(str) as Map<String, dynamic>);

String toolCategoryToJson(ToolCategory data) => json.encode(data.toJson());

class ToolCategory {

    ToolCategory({
        this.numberOfTools,
        this.uuid,
        this.name,
        this.description,
    });

    factory ToolCategory.fromJson(Map<String, dynamic> json) => ToolCategory(
        numberOfTools: json['numberOfTools'] as int,
        uuid: json['uuid'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
    );
    int? numberOfTools;
    String? uuid;
    String? name;
    String? description;

    ToolCategory copyWith({
        int? numberOfTools,
        String? uuid,
        String? name,
        String? description,
    }) => 
        ToolCategory(
            numberOfTools: numberOfTools ?? this.numberOfTools,
            uuid: uuid ?? this.uuid,
            name: name ?? this.name,
            description: description ?? this.description,
        );

    Map<String, dynamic> toJson() => {
        'numberOfTools': numberOfTools,
        'uuid': uuid,
        'name': name,
        'description': description,
    };
}
