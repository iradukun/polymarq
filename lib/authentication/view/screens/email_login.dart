import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/authentication/models/response_models/login_response_model.dart';
import 'package:polymarq/authentication/view_models/auth_view_model.dart';
import 'package:polymarq/providers/storage.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_auth_textfield.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      YMargin(context.height * 100 / AppConstants.designHeight),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 48, 32, 32),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      YMargin(context.height * 50 / AppConstants.designHeight),
                      CustomAuthTextField(
                        hintText: 'Email',
                        prefixImage: 'assets/icons/inbox.svg',
                        controller: authViewModel.emailController,
                        validator: (value) {
                          if ((value ?? '').isEmail) {
                            return null;
                          }
                          return 'Please enter a valid email';
                        },
                      ),
                      YMargin(context.height * 30 / AppConstants.designHeight),
                      CustomAuthTextField(
                        hintText: 'Password',
                        prefixImage: 'assets/icons/lock.svg',
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
                        obscureText: passwordVisible,
                        controller: authViewModel.passwordController,
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          if ((value ?? '').length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      YMargin(context.height * 30 / AppConstants.designHeight),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.emailForgotPasswordPage,
                            );
                            authViewModel.clearAllControllers();
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: AppColor.iris,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
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
                            context.width * 10 / AppConstants.designWidth,
                          ),
                          const Text(
                            'Continue With',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackGrey,
                            ),
                          ),
                          XMargin(
                            context.width * 10 / AppConstants.designWidth,
                          ),
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
                            context.width * 10 / AppConstants.designWidth,
                          ),
                          SvgPicture.asset('assets/icons/facebook.svg'),
                        ],
                      ),
                      YMargin(context.height * 170 / AppConstants.designHeight),
                      CustomButton(
                        buttonText: 'Continue',
                        onTap: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            final response = await authViewModel.signIn();
                            if (response.isSuccessful && context.mounted) {
                              final logInResponseModel =
                                  LoginResponseModel.fromJson(response.data);
                              final firstName =
                                  logInResponseModel.user?.firstName ?? '';
                              final lastName =
                                  logInResponseModel.user?.lastName ?? '';
                              if (firstName.trim().isEmpty &&
                                  lastName.trim().isEmpty) {
                                unawaited(
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoute.personalInfoPage,
                                    (route) => false,
                                  ),
                                );
                                unawaited(
                                  CustomAlert.show(
                                    context,
                                    success: true,
                                    message:
                                        'Welcome to Polymarq, please complete your profile',
                                  ),
                                );
                              } else {
                                MyPref.accessToken =
                                    logInResponseModel.tokens?.access ?? '';
                                MyPref.refreshToken =
                                    logInResponseModel.tokens?.refresh ?? '';
                                MyPref.user = logInResponseModel.user;
                                unawaited(
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoute.bottomNavBar,
                                    (route) => false,
                                  ),
                                );
                              }
                              authViewModel.emailController.clear();
                              authViewModel.passwordController.clear();
                            } else {
                              unawaited(
                                CustomAlert.show(
                                  context,
                                  message:
                                      response.message ?? 'An error occurred',
                                ),
                              );
                            }
                          }
                        },
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      RichText(
                        text: TextSpan(
                          text: 'Never Joined before? ',
                          style: const TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoute.emailSignupPage,
                                  );
                                  authViewModel.clearAllControllers();
                                },
                              text: 'Sign up',
                              style: const TextStyle(
                                color: AppColor.iris,
                                fontWeight: FontWeight.w600,
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
