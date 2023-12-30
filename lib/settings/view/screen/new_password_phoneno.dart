import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/settings/viewmodels/profile_view_model.dart';
import 'package:polymarq/settings/viewmodels/state/profile_state.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class NewPasswordPhoneNoScreen extends ConsumerStatefulWidget {
  const NewPasswordPhoneNoScreen({
    required this.otp, super.key,
  });
  final String otp;

  @override
  ConsumerState<NewPasswordPhoneNoScreen> createState() =>
      _NewPasswordPhoneNoScreenState();
}

class _NewPasswordPhoneNoScreenState
    extends ConsumerState<NewPasswordPhoneNoScreen> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool newPasswordVisible = false;
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen(settingViewModelProvider, (prev, next) {
      if (next is NewPasswordFailure) {
        CustomAlert.show(context, message: next.message);
      }
      if (next is NewPasswordSuccess) {
        CustomAlert.show(context,
            message: 'password changed successfully', success: true,);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.securityPage,
            (route) => false,
          );
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Change Password',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width * 20 / AppConstants.designWidth,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(context.height * 20 / AppConstants.designHeight),
            const Text(
              'Old Password',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.whiteGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            CustomTextFieild(
              color: AppColor.black,
              textName: '**********',
              controller: _oldPassword,
              suffixImage: InkWell(
                onTap: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
                child: Image.asset(
                  passwordVisible == true
                      ? 'assets/images/voice.png'
                      : 'assets/images/visibility_off.png',
                  color: AppColor.black,
                ),
              ),
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            const Text(
              'New Password',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.whiteGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            CustomTextFieild(
              color: AppColor.black,
              controller: _newPassword,
              textName: '**********',
              suffixImage: InkWell(
                onTap: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
                child: Image.asset(
                  passwordVisible == true
                      ? 'assets/images/voice.png'
                      : 'assets/images/visibility_off.png',
                  color: AppColor.black,
                ),
              ),
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            const Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.whiteGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            CustomTextFieild(
              color: AppColor.black,
              textName: '**********',
              controller: _confirmPassword,
              suffixImage: InkWell(
                onTap: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
                child: Image.asset(
                  passwordVisible == true
                      ? 'assets/images/voice.png'
                      : 'assets/images/visibility_off.png',
                  color: AppColor.black,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: context.height * 20 / AppConstants.designHeight,),
              child: CustomButton(
                  buttonText: 'Save',
                  onTap: () {
                    ref
                        .watch(settingViewModelProvider.notifier)
                        .newPasswordWithPhoneNo(
                            password: _oldPassword.text,
                            newPassword: _newPassword.text,
                            otp: widget.otp,);
                  },),
            ),
          ],
        ),
      ),
    );
  }
}
