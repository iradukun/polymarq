import 'package:dio/dio.dart';
import 'package:polymarq/providers/api_response.dart';

abstract class SettingsRepository {
  Future<ApiResponse> updateProfile(dynamic body);
  Future<ApiResponse> updateProfilePicture(FormData formData);
  Future<ApiResponse> getProfile();
  Future<ApiResponse> deleteAccount({required String password});
  Future<ApiResponse> changePasswordWithEmail({required String email});
  Future<ApiResponse> verifyPasswordWithEmail({required String otp});
  Future<ApiResponse> newPasswordWithEmail({
    required String password,
    required String newPassword,
    required String otp,
  });
  Future<ApiResponse> changePasswordWithPhoneNo({required String phoneNo});
  Future<ApiResponse> verifyPasswordWithPhoneNo({required String otp});
  Future<ApiResponse> newPasswordWithPhoneNo({
    required String password,
    required String newPassword,
    required String otp,
  });
  Future<ApiResponse> createBankAccount({
    required String bankSlug,
    required String accountName,
    required String accountnumber,
  });
}
