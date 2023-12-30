// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
ErrorResponseModel errorResponseModelFromJson(String str) => ErrorResponseModel.fromJson(json.decode(str));
String errorResponseModelToJson(ErrorResponseModel data) => json.encode(data.toJson());
class ErrorResponseModel {
  ErrorResponseModel({
      this.success, 
      this.error,});

  ErrorResponseModel.fromJson(dynamic json) {
    success = json['success'] as bool?;
    if (json['error'] != null) {
      error = [];
      // ignore: inference_failure_on_untyped_parameter
      json['error'].forEach((v) {
        error?.add(Error.fromJson(v));
      });
    }
  }
  bool? success;
  List<Error>? error;
ErrorResponseModel copyWith({  bool? success,
  List<Error>? error,
}) => ErrorResponseModel(  success: success ?? this.success,
  error: error ?? this.error,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (error != null) {
      map['error'] = error?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Error errorFromJson(String str) => Error.fromJson(json.decode(str));
String errorToJson(Error data) => json.encode(data.toJson());
class Error {
  Error({
      this.code, 
      this.message, 
      this.details,});

  Error.fromJson(dynamic json) {
    code = json['code'] as String?;
    message = json['message'] as String?;
    details = json['details'] as String?;
  }
  String? code;
  String? message;
  String? details;
Error copyWith({  String? code,
  String? message,
  String? details,
}) => Error(  code: code ?? this.code,
  message: message ?? this.message,
  details: details ?? this.details,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['details'] = details;
    return map;
  }

}