import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:polymarq/settings/view/screen/new_password_email.dart';
import 'package:polymarq/settings/viewmodels/profile_view_model.dart';
import 'package:polymarq/settings/viewmodels/state/profile_state.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class OTPPhoneNo extends ConsumerWidget {
  OTPPhoneNo({
    required this.phoneNo, super.key,
  });
  final String phoneNo;
  final FocusNode _pinPutFocusNode = FocusNode();
  final _otpController = TextEditingController();
   final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    ref.listen(settingViewModelProvider, (prev, next) {
      if (next is VerifyPasswordFailure) {
        CustomAlert.show(context, message: next.message);
      }
      if (next is VerifyPasswordSuccess) {
        CustomAlert.show(context,
            message: 'Email verified successfully', success: true,);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewPasswordEmailScreen(otp: _otpController.text),),);
        });
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              YMargin(context.height * 100 / AppConstants.designHeight),
              const Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColor.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
              YMargin(context.height * 20 / AppConstants.designHeight),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Please enter the verification code sent\nto:  ',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (kDebugMode) {
                            print('Tap Here onTap');
                          }
                        },
                      text: phoneNo,
                      style: const TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              YMargin(context.height * 30 / AppConstants.designHeight),
              RichText(
                text: TextSpan(
                  text: "Didn't receive an OTP?  ",
                  style: const TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (kDebugMode) {
                            print('Tap Here onTap');
                          }
                        },
                      text: 'Resend',
                      style: const TextStyle(
                        color: AppColor.iris,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              YMargin(context.height * 30 / AppConstants.designHeight),
              Pinput(
                defaultPinTheme: PinTheme(
                  width: context.height * 56 / 891,
                  height: context.height * 56 / 891,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(30, 60, 87, 1),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.lightBlue,
                    border: Border.all(color: AppColor.lightGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                length: 6,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                focusNode: _pinPutFocusNode,
                controller: _otpController,
                textInputAction: TextInputAction.done,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //separator: const XMargin(3),
                onChanged: (pin) {
                  // setState(() {
                  //   proceedWithPin = pin.length == inputLength;
                  // });
                  // if (pin.length == inputLength) {
                  //   resetTimer();
                  // }
                },
                validator: (pin) {
                  if ((pin ?? '').isEmpty) {
                    return 'Please enter a valid otp';
                  } else if ((pin ?? '').length < 6) {
                    return 'Please enter a valid otp';
                  }
                  return null;
                },
              ),
              const Spacer(),
              CustomButton(
                buttonText: 'Next',
                onTap: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    await ref
                        .watch(settingViewModelProvider.notifier)
                        .verifyPasswordWithPhoneNo(otp: _otpController.text);
                  }
                },
              ),
              YMargin(context.height * 50 / AppConstants.designHeight),
            ],
          ),
        ),
      ),
    );
  }
}
