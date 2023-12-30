import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:polymarq/authentication/view_models/auth_view_model.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class PhoneNoForgotPasswordOtpScreen extends StatelessWidget {
  PhoneNoForgotPasswordOtpScreen({super.key});
  final FocusNode _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Consumer(
      builder: (context, ref, child) {
        final authViewModel = ref.watch(authViewModelProvider);
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
                          text: authViewModel.emailController.text,
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
                              authViewModel.forgotPassword(
                                context,
                                resend: true,
                              );
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
                    controller: authViewModel.otpController,
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
                        return 'Please enter a valid pin';
                      } else if ((pin ?? '').length < 6) {
                        return 'Please enter a valid pin';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    buttonText: 'Next',
                    onTap: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final response = await authViewModel.verifyPhoneOTP();
                        if (response.isSuccessful && context.mounted) {
                          unawaited(Navigator.pushNamed(
                              context, AppRoute.phoneNoPasswordPage,),);
                          await CustomAlert.show(context,
                              message:
                                  'OTP verified successfully, please enter a new password',
                              success: true,);
                        } else {
                          unawaited(CustomAlert.show(context,
                              message:
                                  response.message ?? 'An error occurred',),);
                        }
                      }
                    },
                  ),
                  YMargin(context.height * 50 / AppConstants.designHeight),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
