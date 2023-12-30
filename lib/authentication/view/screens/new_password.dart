import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/authentication/view_models/auth_view_model.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_auth_textfield.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authViewModel = ref.watch(authViewModelProvider);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 20 / AppConstants.designWidth,),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    YMargin(context.height * 80 / AppConstants.designHeight),
                    Text(
                      'New Password',
                      style: TextStyle(
                        fontSize:
                            context.height * 30 / AppConstants.designHeight,
                        color: AppColor.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    YMargin(context.height * 50 / AppConstants.designHeight),
                    CustomAuthTextField(
                      controller: authViewModel.passwordController,
                      hintText: 'Enter your new password',
                      obscureText: !passwordVisible,
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
                      validator: (value) {
                        if ((value ?? '').length >= 6) {
                          return null;
                        }
                        return 'Password must be at least 6 characters';
                      },
                    ),
                    YMargin(context.height * 40 / AppConstants.designHeight),
                    CustomAuthTextField(
                      controller: authViewModel.confirmPasswordController,
                      obscureText: !confirmPasswordVisible,
                      hintText: 'Confirm your new password',
                      suffixImage: InkWell(
                        onTap: () {
                          setState(
                            () {
                              confirmPasswordVisible = !confirmPasswordVisible;
                            },
                          );
                        },
                        child: Image.asset(
                          confirmPasswordVisible == true
                              ? 'assets/images/voice.png'
                              : 'assets/images/visibility_off.png',
                          color: AppColor.black,
                        ),
                      ),
                      validator: (value) {
                        if (authViewModel.passwordController.text.isEmpty) {
                          return 'Please enter a password';
                        } else if ((value ?? '').isEmpty) {
                          return 'Please confirm your password';
                        } else if (authViewModel.passwordController.text !=
                            value) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              context.height * 20 / AppConstants.designHeight,),
                      child: CustomButton(
                        buttonText: 'Save',
                        onTap: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            final response =
                                await authViewModel.resetForgotPassword();
                            if (response.isSuccessful && context.mounted) {
                              authViewModel.emailController.clear();
                              authViewModel.passwordController.clear();
                               
                                await CustomAlert.show(context,
                                    message:
                                        'Password reset successfully, please login',
                                    success: true,
                              );
                              unawaited(
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoute.emailLoginPage,
                                  (route) => false,
                                ),
                              );
                              authViewModel.otpController.clear();
                             
                            } else {
                              unawaited(CustomAlert.show(context,
                                  message:
                                      response.message ?? 'An error occurred',),);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
