import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/providers/api.dart';
import 'package:polymarq/providers/api_response.dart';
import 'package:polymarq/providers/constants.dart';
import 'package:polymarq/settings/repository/settings_repository.dart';

final settingsRepositoryProvider =
    Provider((ref) => SettingsRepositoryImpl(ref.watch(apiProvider)));

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this.api);
  final Api api;

  @override
  Future<ApiResponse> updateProfile(dynamic body) {
    final response =
        api.patchData(ApiConstant.UPDATE_PROFILE, body: body, hasHeader: true);
    return response;
  }

  @override
  Future<ApiResponse> updateProfilePicture(FormData formData) {
    final response = api.postData(
      ApiConstant.UPDATE_PROFILE_PICTURE,
      body: formData,
      hasHeader: true,
    );
    return response;
  }

  @override
  Future<ApiResponse> getProfile() {
    final response = api.getData(
      ApiConstant.GET_USER,
      hasHeader: true,
    );

    return response;
  }

  @override
  Future<ApiResponse> deleteAccount({required String password}) {
    final body = {
      'password': password,
    };
    final response = api.deleteData(
      ApiConstant.GET_USER,
      hasHeader: true,
      body: body,
    );

    return response;
  }

  @override
  Future<ApiResponse> changePasswordWithEmail({required String email}) {
    final body = {
      'email': email,
    };
    final response = api.postData(ApiConstant.PASSWORD_RESET, body: body);
    return response;
  }

  @override
  Future<ApiResponse> changePasswordWithPhoneNo({required String phoneNo}) {
    final body = {
      'phone_number': phoneNo,
    };
    final response =
        api.postData(ApiConstant.PHONENO_PASSWORD_RESET, body: body);
    return response;
  }

  @override
  Future<ApiResponse> newPasswordWithEmail({
    required String password,
    required String newPassword,
    required String otp,
  }) {
    final body = {
      'old_password': password,
      'password': newPassword,
      'token': otp,
    };
    final response = api.postData(ApiConstant.PHONENO_PASSWORD_RESET_CONFIRM,
        body: body, hasHeader: true,);
    return response;
  }

  @override
  Future<ApiResponse> newPasswordWithPhoneNo({
    required String password,
    required String newPassword,
    required String otp,
  }) {
    final body = {
      'old_password': password,
      'password': newPassword,
      'token': otp,
    };
    final response = api.postData(ApiConstant.PHONENO_PASSWORD_RESET_CONFIRM,
        body: body, hasHeader: true,);
    return response;
  }

  @override
  Future<ApiResponse> verifyPasswordWithEmail({required String otp}) {
    final body = {
      'token': otp,
    };
    final response = api.postData(
        ApiConstant.PHONENO_PASSWORD_RESET_VALIDATE_TOKEN,
        body: body,);
    return response;
  }

  @override
  Future<ApiResponse> verifyPasswordWithPhoneNo({required String otp}) {
    final body = {
      'token': otp,
    };
    final response =
        api.postData(ApiConstant.PASSWORD_RESET_VALIDATE_TOKEN, body: body);
    return response;
  }

  @override
  Future<ApiResponse> createBankAccount(
      {required String bankSlug,
      required String accountName,
      required String accountnumber,}) {
    final body = {
      'bank_slug': bankSlug,
      'account_name': accountName,
      'account_number': accountnumber,
    };
    final response = api.postData(ApiConstant.BANK_ACCOUNT, body: body,
    hasHeader: true,);
    return response;
  }
}
