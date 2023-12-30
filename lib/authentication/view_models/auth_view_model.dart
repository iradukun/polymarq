// ignore_for_file: flutter_style_todos

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/authentication/models/response_models/login_response_model.dart';
import 'package:polymarq/authentication/repository/auth_repository.dart';
import 'package:polymarq/authentication/repository/auth_repository_impl.dart';
import 'package:polymarq/providers/api_response.dart';
import 'package:polymarq/providers/location/location_service.dart';
import 'package:polymarq/providers/storage.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/extension.dart';

final authViewModelProvider = Provider(
  (ref) => AuthViewModel(
    ref.watch(authRepositoryProvider),
    ref.watch(locationProvider),
  ),
);

class AuthViewModel {
  AuthViewModel(this._authRepository, this.locationService);
  final AuthRepository _authRepository;
  final LocationService locationService;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  //email auth
  Future<ApiResponse> signUpWithEmail() async {
    final response = await _authRepository.signUpWithEmail(
      emailController.text,
      passwordController.text,
    );
    return response;
  }

  Future<ApiResponse> verifyOTP() async {
    final response = await _authRepository.verifyOTP(
      emailController.text,
      otpController.text,
    );
    if (response.isSuccessful) {
      emailController.clear();
      confirmPasswordController.clear();
      otpController.clear();
    }
    return response;
  }

  Future<ApiResponse> signIn() async {
    final deviceType = Platform.isAndroid ? 1 : 0;
    final token = await FirebaseMessaging.instance.getToken() ?? '';
    log.d(
      'token: $token , deviceType: $deviceType, phone:${emailController.text}',
    );
    final response = await _authRepository.signIn(
      emailController.text,
      passwordController.text,
      deviceType,
      token,
    );
    if (response.isSuccessful) {
      final logInResponseModel = LoginResponseModel.fromJson(response.data);

      MyPref.accessToken = logInResponseModel.tokens?.access ?? '';
      MyPref.refreshToken = logInResponseModel.tokens?.refresh ?? '';
      MyPref.uuid = logInResponseModel.user?.uuid ?? '';
      user = logInResponseModel.user;
      print('kk ${MyPref.uuid}');
    }
    return response;
  }

  Future<ApiResponse> forgotPassword(
    BuildContext context, {
    bool resend = false,
  }) async {
    final response = await _authRepository.forgotPassword(emailController.text);
    if (response.isSuccessful && context.mounted) {
      unawaited(
        CustomAlert.show(
          context,
          message: 'OTP sent successfully, please check your email',
        ),
      );
      if (!resend) {
        unawaited(
          Navigator.pushNamed(context, AppRoute.emailForgotPassswordOtpPage),
        );
        await CustomAlert.show(context,
            message: 'OTP sent successfully, please check your email',
            success: true,);
      }
    } else {
      unawaited(
        CustomAlert.show(
          context,
          message: response.message ?? 'An error occurred',
        ),
      );
    }
    return response;
  }

  Future<ApiResponse> verifyForgotPasswordOTP() async {
    final response =
        await _authRepository.verifyForgotPasswordOTP(otpController.text);
    return response;
  }

  Future<ApiResponse> resetForgotPassword() async {
    final response = await _authRepository.resetForgotPassword(
      passwordController.text,
      otpController.text,
    );
    return response;
  }

  //phone number auth
  Future<ApiResponse> signInWithPhone() async {
    final deviceType = Platform.isAndroid ? 1 : 0;
    final token = await FirebaseMessaging.instance.getToken() ?? '';
    log.d(
      'token: $token , deviceType: $deviceType, phone:${phoneController.text}',
    );
    final response = await _authRepository.signIn(
      phoneController.text.phoneNumber,
      passwordController.text,
      deviceType,
      token,
    );
    if (response.isSuccessful) {
      final logInResponseModel = LoginResponseModel.fromJson(response.data);
      if (logInResponseModel.user != null) {
        MyPref.accessToken = logInResponseModel.tokens?.access ?? '';
        MyPref.refreshToken = logInResponseModel.tokens?.refresh ?? '';
        MyPref.uuid = logInResponseModel.user?.uuid ?? '';
        user = logInResponseModel.user;
      }
    }
    return response;
  }

  Future<ApiResponse> signUpWithPhone() async {
    final response = await _authRepository.signUpWithPhone(
      phoneController.text.phoneNumber.phoneNumber,
      passwordController.text,
    );
    if (response.isSuccessful) {
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      otpController.clear();
    }
    return response;
  }

  Future<ApiResponse> sendPhoneOTP(
    BuildContext context, {
    bool resend = false,
  }) async {
    final response =
        await _authRepository.sendPhoneOTP(phoneController.text.phoneNumber);
    if (response.isSuccessful && context.mounted) {
      unawaited(
        CustomAlert.show(
          context,
          message: 'OTP sent successfully, please check your email',
        ),
      );
      if (!resend) {
        unawaited(
          Navigator.pushNamed(context, AppRoute.forgotPhoneOTPPage),
        );
        await CustomAlert.show(context,
            message: 'OTP sent successfully, please check your email',
            success: true,);
      }
    } else {
      unawaited(
        CustomAlert.show(
          context,
          message: response.message ?? 'An error occurred',
        ),
      );
    }
    return response;
  }

  Future<ApiResponse> verifyPhoneOTP() async {
    final response = await _authRepository.verifyPhoneOTP(
      phoneController.text.phoneNumber,
      otpController.text,
    );
    if (response.isSuccessful) {
      otpController.clear();
    }
    return response;
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController servicesOfferedController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController lgaController = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController workDescription = TextEditingController();
  TextEditingController servicesOffered = TextEditingController();
  TextEditingController workAddress = TextEditingController();
  TextEditingController selectedCertificateController = TextEditingController();
  File? selectedCertificate;
  User? user;

  Future<ApiResponse> completeSignUP() async {
    final location =
        await locationService.getCurrentPosition().catchError((err) {
      // throw AppException(
      //   'Please enable location and check internet, try again',
      // );
    });
    final file = await MultipartFile.fromFile(selectedCertificate!.path);
    final body = {
      'user': jsonEncode({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'longitude': location?.longitude ?? 0,
        'latitude': location?.latitude ?? 0,
      }),
      'certificates': [
        {
          'file': file,
        }
      ],
      'professional_summary': workDescription.text,
      'country': countryController.text,
      'city': cityController.text,
      'local_government_area': lgaController.text,
      'work_address': workAddress.text,
      'services': servicesOffered.text,
    };
    final formData = FormData.fromMap(body);
    final response = await _authRepository.completeSignUp(formData);
    if (response.isSuccessful && user != null) {
      MyPref.user = user;
    }
    return response;
  }

  void clearAllControllers() {
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    otpController.clear();
    firstNameController.clear();
    lastNameController.clear();
    servicesOfferedController.clear();
    countryController.clear();
    cityController.clear();
    lgaController.clear();
    description.clear();
    address.clear();
  }
}
