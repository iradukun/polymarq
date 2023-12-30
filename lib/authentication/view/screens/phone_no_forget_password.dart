import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/authentication/view_models/auth_view_model.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_auth_textfield.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class PhoneNoForgetPasswordScreen extends StatelessWidget {
  const PhoneNoForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Consumer(
      builder: (context, ref, child) {
        final authViewModel = ref.watch(authViewModelProvider);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YMargin(context.height * 100 / AppConstants.designHeight),
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize:
                            context.height * 30 / AppConstants.designHeight,
                        color: AppColor.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    YMargin(context.height * 20 / AppConstants.designHeight),
                    const Text(
                      "Don't worry! Please enter the phone number associate\nto your account to verify.",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500,),
                    ),
                    YMargin(context.height * 40 / AppConstants.designHeight),
                    CustomAuthTextField(
                      controller: authViewModel.phoneController,
                      hintText: 'Enter Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!(value ?? '').isValidPhoneNumber) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    YMargin(context.height * 50 / AppConstants.designHeight),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoute.phonenoForgotPasswordPage,);
                          },
                          child: const Text(
                            'Use Email Address Instead',
                            style: TextStyle(
                                color: AppColor.iris,
                                fontWeight: FontWeight.w500,),
                          ),),
                    ),
                    YMargin(context.height * 300 / AppConstants.designHeight),
                    CustomButton(
                      buttonText: 'Continue',
                      onTap: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          await authViewModel.sendPhoneOTP(context);
                        }
                      },
                    ),
                    YMargin(context.height * 20 / AppConstants.designHeight),
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
