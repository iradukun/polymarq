import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/settings/view/screen/otp_email.dart';
import 'package:polymarq/settings/viewmodels/profile_view_model.dart';
import 'package:polymarq/settings/viewmodels/state/profile_state.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class ChangePasswordEmailScreen extends ConsumerStatefulWidget {
  const ChangePasswordEmailScreen({
    super.key,
  });

  @override
  ConsumerState<ChangePasswordEmailScreen> createState() =>
      _ChangePasswordEmailScreenState();
}

class _ChangePasswordEmailScreenState
    extends ConsumerState<ChangePasswordEmailScreen> {
  final _emailController = TextEditingController();
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    ref.listen(settingViewModelProvider, (prev, next) {
      if (next is ChangePasswordFailure) {
        CustomAlert.show(context, message: next.message);
      }
      if (next is ChangePasswordSuccess) {
        CustomAlert.show(context, message: next.message, success: true);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPEmail(email: _emailController.text),
            ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 20 / AppConstants.designWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(context.height * 30 / AppConstants.designHeight),
              const Text(
                'Enter your email',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.blackGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              YMargin(context.height * 10 / AppConstants.designHeight),
              CustomTextFieild(
                color: AppColor.black,
                textName: 'johnsnow@gmail.com',
                controller: _emailController,
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
              YMargin(context.height * 400 / AppConstants.designHeight),
              Padding(
                padding: EdgeInsets.only(
                  bottom: context.height * 20 / AppConstants.designHeight,
                ),
                child: CustomButton(
                  buttonText: 'Save',
                  onTap: () {
                    ref
                        .read(settingViewModelProvider.notifier)
                        .changePasswordWithEmail(email: _emailController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
