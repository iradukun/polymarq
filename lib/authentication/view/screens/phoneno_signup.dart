import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/authentication/view_models/auth_view_model.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_auth_textfield.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class PhoneNoSignupScreen extends StatefulWidget {
  const PhoneNoSignupScreen({super.key});

  @override
  State<PhoneNoSignupScreen> createState() => _PhoneNoSignupScreenState();
}

class _PhoneNoSignupScreenState extends State<PhoneNoSignupScreen> {
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    YMargin(
                      context.height * 100 / 891,
                    ),
                    const  Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize:  30 ,
                        color: AppColor.black,
                        fontWeight: FontWeight.w900,),
                    ),
                    YMargin(
                      context.height * 100 / 891,
                    ),
                    CustomAuthTextField(
                      controller: authViewModel.phoneController,
                      hintText: 'Enter Phone Number',
                      prefixImage: 'assets/icons/call.svg',
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please enter your phone number';
                        }else if(!(value ?? '').isValidPhoneNumber){
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    YMargin(
                      context.height * 150 / 891,
                    ),
                    SvgPicture.asset('assets/icons/speaker.svg'),
                    YMargin(
                      context.height * 10 / 891,
                    ),
                    const Text(
                      'Tap to Speak your Phone number',
                      style: TextStyle(color: AppColor.whiteGrey, fontSize: 12),
                    ),
                    YMargin(
                      context.height * 130 / 891,
                    ),
                    CustomButton(
                      buttonText: 'Continue',
                      onTap: () async {
                        if(formKey.currentState!.validate()){
                          if(formKey.currentState?.validate() ?? false) {
                            final response = await authViewModel.sendPhoneOTP(context);
                            if(response.isSuccessful && context.mounted){
                              unawaited(Navigator.pushNamed(context, AppRoute.phoneNoOtpPage));
                              unawaited(CustomAlert.show(context, success: true, message: 'Please check your phone for a verification code'));
                            }else{
                              unawaited(CustomAlert.show(context, message: response.message ?? 'An error occurred'));
                            }
                          }
                        }
                      },
                    ),
                    YMargin(
                      context.height * 20 / 891,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Joined us before ? ',
                        style: const TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, AppRoute.phonenoLoginPage);
                                authViewModel.phoneController.clear();
                              },
                            text: 'Login',
                            style: const TextStyle(
                              color: AppColor.iris,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,),
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
