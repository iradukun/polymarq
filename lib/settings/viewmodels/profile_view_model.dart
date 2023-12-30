
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/settings/repository/settings_repository_impl.dart';
import 'package:polymarq/settings/viewmodels/state/profile_state.dart';

final settingViewModelProvider =
    StateNotifierProvider.autoDispose<ProfileViewModel, ProfileState>((ref) {
  final settingRepository = ref.watch(settingsRepositoryProvider);

  return ProfileViewModel(
    settingRepository,
  );
});

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(this.settingsRepositoryImpl) : super(ProfileInitial());
  final SettingsRepositoryImpl settingsRepositoryImpl;

  Future<void> changePasswordWithEmail({
    required String email,
  }) async {
    try {
      state = ChangePasswordLoading();
      final response =
          await settingsRepositoryImpl.changePasswordWithEmail(email: email);
      if (response.isSuccessful) {
        state = ChangePasswordSuccess(
          message: response.message ?? 'Verified successfully',
        );
      } else {
        state = ChangePasswordFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = ChangePasswordFailure(message: e.toString());
    }
  }

  Future<void> verifyPasswordWithEmail({
    required String otp,
  }) async {
    try {
      state = VerifyPasswordLoading();
      final response =
          await settingsRepositoryImpl.verifyPasswordWithEmail(otp: otp);
      if (response.isSuccessful) {
        state = VerifyPasswordSuccess(
          message: response.message ?? 'Verified successfully',
        );
      } else {
        state = VerifyPasswordFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = VerifyPasswordFailure(message: e.toString());
    }
  }

  Future<void> newPasswordWithEmail(
      {required String password,
      required String newPassword,
      required String otp,}) async {
    try {
      state = NewPasswordLoading();
      final response = await settingsRepositoryImpl.newPasswordWithEmail(
          password: password, newPassword: newPassword, otp: otp,);
      if (response.isSuccessful) {
        state = NewPasswordSuccess(
          message: response.message ?? 'Verified successfully',
        );
      } else {
        state = NewPasswordFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = NewPasswordFailure(message: e.toString());
    }
  }

  Future<void> changePasswordWithPhoneNo({
    required String phoneNo,
  }) async {
    try {
      state = ChangePasswordLoading();
      final response = await settingsRepositoryImpl.changePasswordWithPhoneNo(
          phoneNo: phoneNo,);
      if (response.isSuccessful) {
        state = ChangePasswordSuccess(
          message: response.message ?? 'Verified successfully',
        );
      } else {
        state = ChangePasswordFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = ChangePasswordFailure(message: e.toString());
    }
  }
   Future<void> createBankAccount({
     required String bankSlug,
    required String accountName,
    required String accountnumber,
  }) async {
    try {
      state = CreateBankAccountLoading();
      final response = await settingsRepositoryImpl.createBankAccount(bankSlug
      : bankSlug, accountName: accountName, accountnumber: accountnumber,);
      if (response.isSuccessful) {
        state = CreateBankAccountSuccess(
          message: response.message ?? 'Verified successfully',
        );
      } else {
        state = CreateBankAccountFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = CreateBankAccountFailure(message: e.toString());
    }
  }

  Future<void> verifyPasswordWithPhoneNo({
    required String otp,
  }) async {
    try {
      state = VerifyPasswordLoading();
      final response =
          await settingsRepositoryImpl.verifyPasswordWithPhoneNo(otp: otp);
      if (response.isSuccessful) {
        state = VerifyPasswordSuccess(
          message: response.message ?? 'Verified successfully',
        );
      } else {
        state = VerifyPasswordFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = VerifyPasswordFailure(message: e.toString());
    }
  }

  Future<void> deleteAccount({required String password}) async {
    try {
      state = DeleteAccountLoading();
      final response =
          await settingsRepositoryImpl.deleteAccount(password: password);
      if (response.isSuccessful) {
        state = DeleteAccountSuccess(
          message: response.message ?? 'Verified successfully',
        );
      } else {
        state = DeleteAccountFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = DeleteAccountFailure(message: e.toString());
    }
  }

  Future<void> newPasswordWithPhoneNo(
      {required String password,
      required String newPassword,
      required String otp,}) async {
    try {
      state = NewPasswordLoading();
      final response = await settingsRepositoryImpl.newPasswordWithPhoneNo(
          password: password, newPassword: newPassword, otp: otp,);
      if (response.isSuccessful) {
        state = NewPasswordSuccess(
          message: response.message ?? 'Verified successfully',
        );
      } else {
        state = NewPasswordFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = NewPasswordFailure(message: e.toString());
    }
  }
}
