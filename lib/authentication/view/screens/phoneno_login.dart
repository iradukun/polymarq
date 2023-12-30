import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class PhoneNoLoginScreen extends StatefulWidget {
  const PhoneNoLoginScreen({super.key});

  @override
  State<PhoneNoLoginScreen> createState() => _PhoneNoLoginScreenState();
}

class _PhoneNoLoginScreenState extends State<PhoneNoLoginScreen> {
  bool passwordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.width * 20 / AppConstants.designWidth,),
              child: Form(
                key: formKey,
                child: Column(children: [
                  YMargin(context.height * 80 / AppConstants.designHeight),
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30 ,
                      color: AppColor.black,
                      fontWeight: FontWeight.w900,),
                  ),
                  YMargin(context.height * 40 / AppConstants.designHeight),
                  CustomAuthTextField(
                    controller: authViewModel.phoneController,
                    hintText: 'Phone number',
                    prefixImage: 'assets/icons/call.svg',
                    suffixImage: Image.asset(
                      'assets/images/voice.png',
                      width: context.width * 29 / AppConstants.designWidth,
                      color: Colors.grey,
                    ),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please enter your phone number';
                      }else if(!(value ?? '').isValidPhoneNumber){
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  YMargin(context.height * 20 / AppConstants.designHeight),
                  CustomAuthTextField(
                    hintText: 'Enter Password',
                    prefixImage: 'assets/icons/lock.svg',
                    obscureText: passwordVisible,
                    controller: authViewModel.passwordController,
                    suffixImage: InkWell(
                      onTap: () {
                        setState(
                              () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                      child: Image.asset(passwordVisible == true
                          ? 'assets/images/unvisible.png'
                          : 'assets/images/visibility_off.png',),),
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
                        Navigator.pushNamed(context, AppRoute.phonenoForgotPasswordPage,);
                        authViewModel.clearAllControllers();
                      },
                      child: const Text('Forgot Password',
                        style: TextStyle(
                          color: AppColor.iris,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,),),
                    ),
                  ),
                  YMargin(context.height * 40 / AppConstants.designHeight),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.emailLoginPage);
                      authViewModel.clearAllControllers();
                    },
                    child: Container(
                      height: context.height * 50 / AppConstants.designHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColor.iris, width: 1.5),),
                      child: const Center(
                        child: Text(
                          'Use Email Address Instead',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColor.iris,
                            fontWeight: FontWeight.w600,),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    buttonText: 'Continue',
                    onTap: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final response = await authViewModel.signInWithPhone();
                        if (response.isSuccessful && context.mounted) {
                          final logInResponseModel = LoginResponseModel.fromJson(response.data);
                          final firstName = logInResponseModel.user?.firstName ?? '';
                          final lastName = logInResponseModel.user?.lastName ?? '';
                          if(firstName.trim().isEmpty && lastName.trim().isEmpty) {
                            unawaited(Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoute.personalInfoPage,
                                  (route) => false,
                            ),);
                            unawaited(
                              CustomAlert.show(
                                context,
                                success: true,
                                message: 'Welcome to Polymarq, please complete your profile',
                              ),
                            );
                          }else{
                            MyPref.accessToken = logInResponseModel.tokens?.access ?? '';
                            MyPref.refreshToken = logInResponseModel.tokens?.refresh ?? '';
                            MyPref.user = logInResponseModel.user;
                            unawaited(Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoute.bottomNavBar,
                                  (route) => false,
                            ),);
                            unawaited(
                              CustomAlert.show(
                                context,
                                success: true,
                                message: 'Sign in successful',
                              ),
                            );
                          }
                          authViewModel.emailController.clear();
                          authViewModel.passwordController.clear();
                        } else {
                          unawaited(
                            CustomAlert.show(
                              context,
                              message: response.message ?? 'An error occurred',
                            ),
                          );
                        }
                      }
                    },
                  ),
                  YMargin(context.height * 20 / AppConstants.designHeight),

                  Padding(
                    padding: EdgeInsets.only(
                      bottom: context.height * 20 / AppConstants.designHeight,),
                    child: RichText(
                      text: TextSpan(
                        text: 'Never Joined before? ',
                        style: const TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context, AppRoute.phonenoSignupPage,);
                                authViewModel.clearAllControllers();
                              },
                            text: 'Sign up',
                            style: const TextStyle(
                              color: AppColor.iris,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,),
                          ),
                        ],
                      ),
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
