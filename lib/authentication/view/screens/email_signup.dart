import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/authentication/view/screens/email_login.dart';
import 'package:polymarq/authentication/view_models/auth_view_model.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_auth_textfield.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authViewModel = ref.watch(authViewModelProvider);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      YMargin(context.height * 100 / AppConstants.designHeight),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColor.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      YMargin(context.height * 50 / AppConstants.designHeight),
                      CustomAuthTextField(
                        controller: authViewModel.emailController,
                        hintText: 'Email',
                        prefixImage: 'assets/icons/inbox.svg',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if ((value ?? '').isEmail) {
                            return null;
                          }
                          return 'Please enter a valid email';
                        },
                      ),
                      YMargin(context.height * 30 / AppConstants.designHeight),
                      CustomAuthTextField(
                        controller: authViewModel.passwordController,
                        hintText: 'Password',
                        prefixImage: 'assets/icons/lock.svg',
                        keyboardType: TextInputType.visiblePassword,
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
                                ? 'assets/images/unvisible.png'
                                : 'assets/images/visibility_off.png',
                          ),
                        ),
                        validator: (value) {
                          if ((value ?? '').trim().length >= 8) {
                            return null;
                          }
                          return 'Password must be at least 8 characters';
                        },
                      ),
                      YMargin(context.height * 30 / AppConstants.designHeight),
                      CustomAuthTextField(
                        controller: authViewModel.confirmPasswordController,
                        hintText: 'Confirm Password',
                        prefixImage: 'assets/icons/lock.svg',
                        obscureText: !confirmPasswordVisible,
                        suffixImage: InkWell(
                          onTap: () {
                            setState(
                              () {
                                confirmPasswordVisible =
                                    !confirmPasswordVisible;
                              },
                            );
                          },
                          child: Image.asset(
                            confirmPasswordVisible == true
                                ? 'assets/images/unvisible.png'
                                : 'assets/images/visibility_off.png',
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
                      YMargin(context.height * 30 / AppConstants.designHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width:
                                context.width * 56 / AppConstants.designWidth,
                            height: 2,
                            color: AppColor.whiteGrey,
                          ),
                          XMargin(
                              context.width * 10 / AppConstants.designWidth,),
                          const Text(
                            'Continue With',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackGrey,
                            ),
                          ),
                          XMargin(
                              context.width * 10 / AppConstants.designWidth,),
                          Container(
                            width:
                                context.width * 56 / AppConstants.designWidth,
                            height: 2,
                            color: AppColor.whiteGrey,
                          ),
                        ],
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/google.svg'),
                          XMargin(
                              context.width * 10 / AppConstants.designWidth,),
                          SvgPicture.asset('assets/icons/facebook.svg'),
                        ],
                      ),
                      YMargin(context.height * 170 / AppConstants.designHeight),
                      CustomButton(
                        buttonText: 'Continue',
                        onTap: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            final response =
                                await authViewModel.signUpWithEmail();
                            if (response.isSuccessful && context.mounted) {
                              unawaited(Navigator.pushNamed(
                                  context, AppRoute.emailOtpPage,),);
                              unawaited(CustomAlert.show(context,
                                  success: true,
                                  message:
                                      'Please check your email for a verification code',),);
                            } else {
                              unawaited(CustomAlert.show(context,
                                  message:
                                      response.message ?? 'An error occurred',),);
                            }
                          }
                        },
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      RichText(
                        text: TextSpan(
                          text: 'Joined us before ? ',
                          style: const TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (context) =>
                                          const EmailLoginScreen(),
                                    ),
                                  );
                                  authViewModel.clearAllControllers();
                                },
                              text: 'Login',
                              style: const TextStyle(
                                color: AppColor.iris,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
