import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/authentication/repository/auth_repository.dart';
import 'package:polymarq/providers/api.dart';
import 'package:polymarq/providers/api_response.dart';
import 'package:polymarq/providers/constants.dart';

final authRepositoryProvider =
    Provider((ref) => AuthRepositoryImpl(ref.watch(apiProvider)));

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.api);

  final Api api;

  ///Email
  @override
  Future<ApiResponse> signUpWithEmail(
    String email,
    String password,
  ) {
    final body = {
      'user': {
        'email': email,
        'password': password,
      },
    };
    final response = api.postData(ApiConstant.REGISTER, body: body);
    return response;
  }

  @override
  Future<ApiResponse> signIn(
    String email,
    String password,
    int deviceType,
    String deviceToken,
  ) {
    final body = {
      'username': email,
      'password': password,
      'deviceType': deviceType,
      'deviceToken': deviceToken,
    };
    final response = api.postData(ApiConstant.LOGIN, body: body);
    return response;
  }

  @override
  Future<ApiResponse> verifyOTP(String email, String otp) {
    final body = {
      'email': email,
      'code': otp,
    };
    final response = api.postData(ApiConstant.VERIFY, body: body);
    return response;
  }

  @override
  Future<ApiResponse> forgotPassword(String email) {
    final body = {
      'email': email,
    };
    final response = api.postData(ApiConstant.PASSWORD_RESET, body: body);
    return response;
  }

  @override
  Future<ApiResponse> verifyForgotPasswordOTP(String otp) {
    final body = {
      'token': otp,
    };
    final response =
        api.postData(ApiConstant.PASSWORD_RESET_VALIDATE_TOKEN, body: body);
    return response;
  }

  @override
  Future<ApiResponse> resetForgotPassword(String password, String otp) {
    final body = {
      'password': password,
      'token': otp,
    };
    final response = api.postData(
      ApiConstant.PASSWORD_RESET_CONFIRM,
      body: body,
    );
    return response;
  }

  ///Phone
  @override
  Future<ApiResponse> signUpWithPhone(
    String phone,
    String password, {
    double? latitude,
    double? longitude,
  }) {
    final body = {
      'user': {
        'phone_number': phone,
        'password': password,
      },
      'latitude': latitude ?? 0,
      'longitude': longitude ?? 0,
    };

    final response = api.postData(ApiConstant.REGISTER_WITH_PHONE, body: body);
    return response;
  }

  @override
  Future<ApiResponse> verifyPhoneOTP(String phone, String otp) {
    final body = {
      'phone_number': phone,
      'code': otp,
    };
    final response = api.postData(ApiConstant.VERIFY_PHONE, body: body);
    return response;
  }

  @override
  Future<ApiResponse> sendPhoneOTP(String phone) {
    final body = {
      'phone_number': phone,
    };
    final response =
        api.postData(ApiConstant.RESEND_PHONE_VERIFICATION, body: body);
    return response;
  }

  @override
  Future<ApiResponse> completeSignUp(dynamic body) {
    final response = api.patchData(
      ApiConstant.UPDATE_PROFILE,
      body: body,
      hasHeader: true,
    );
    return response;
  }
  

}
