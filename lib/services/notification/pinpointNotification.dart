// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class PinPointNotification extends Equatable {
  const PinPointNotification({
     this.id,
    this.title,
    this.body,
    this.imageUrl,
    this.imageIconUrl,
  });

  final int? id;
  final String? title;
  final String? body;
  final String? imageUrl;
  final String? imageIconUrl;

  @override
  List<Object?> get props => [id, title, body, imageUrl, imageIconUrl];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'imageIconUrl': imageIconUrl,
    };
  }

  factory PinPointNotification.fromJson(Map<String, dynamic> map) {
    return PinPointNotification(
      id: map['id'] as int?,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      imageIconUrl:
          map['imageIconUrl'] != null ? map['imageIconUrl'] as String : null,
    );
  }
}
