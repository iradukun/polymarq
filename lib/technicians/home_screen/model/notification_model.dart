// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str) as Map<String, dynamic>);

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {

  NotificationModel({
    this.uuid,
    this.title,
    this.body,
    this.isRead,
    this.payload,
    this.createdAt,
    this.createdDisplay,
    this.notificationType,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        uuid: json['uuid'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        isRead: json['isRead'] as bool,
        payload: json['payload'] == null
            ? null
            : Payload.fromJson(
                json['payload'] as Map<String, dynamic>,
              ),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(
                json['createdAt'] as String,
              ),
        createdDisplay: json['createdDisplay'] as String,
        notificationType: json['notificationType'] as String,
      );
  String? uuid;
  String? title;
  String? body;
  bool? isRead;
  Payload? payload;
  DateTime? createdAt;
  String? createdDisplay;
  String? notificationType;

  NotificationModel copyWith({
    String? uuid,
    String? title,
    String? body,
    bool? isRead,
    Payload? payload,
    DateTime? createdAt,
    String? createdDisplay,
    String? notificationType,
  }) =>
      NotificationModel(
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        body: body ?? this.body,
        isRead: isRead ?? this.isRead,
        payload: payload ?? this.payload,
        createdAt: createdAt ?? this.createdAt,
        createdDisplay: createdDisplay ?? this.createdDisplay,
        notificationType: notificationType ?? this.notificationType,
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'body': body,
        'isRead': isRead,
        'payload': payload?.toJson(),
        'createdAt': createdAt?.toIso8601String(),
        'createdDisplay': createdDisplay,
        'notificationType': notificationType,
      };
}

class Payload {

  Payload({
    this.price,
    this.negotiationUuid,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        price: json['price'] as num,
        negotiationUuid: json['negotiationUuid'] as String,
      );
  num? price;
  String? negotiationUuid;

  Payload copyWith({
    num? price,
    String? negotiationUuid,
  }) =>
      Payload(
        price: price ?? this.price,
        negotiationUuid: negotiationUuid ?? this.negotiationUuid,
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        'negotiationUuid': negotiationUuid,
      };
}
