import 'package:polymarq/providers/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse> signUpWithEmail(
    String email,
    String password,
  );
  Future<ApiResponse> signUpWithPhone(String phone, String password);

  Future<ApiResponse> verifyOTP(String email, String otp);
  Future<ApiResponse> verifyPhoneOTP(String phone, String otp);
  Future<ApiResponse> sendPhoneOTP(String phone);

  Future<ApiResponse> signIn(
    String email,
    String password,
    int deviceType,
    String deviceToken,
  );
  Future<ApiResponse> completeSignUp(dynamic body);

  Future<ApiResponse> forgotPassword(String email);
  Future<ApiResponse> verifyForgotPasswordOTP(String otp);
  Future<ApiResponse> resetForgotPassword(String password, String otp);

}
