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

class ConfigPasswordScreen extends StatefulWidget {
  const ConfigPasswordScreen({super.key});

  @override
  State<ConfigPasswordScreen> createState() => _ConfigPasswordScreenState();
}

class _ConfigPasswordScreenState extends State<ConfigPasswordScreen> {
  bool passwordVisible = false;
   bool confirmPasswordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authViewModel = ref.watch(authViewModelProvider);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(children: [
                YMargin(context.height * 100 / AppConstants.designHeight),
                const  Text(
                  'Your Password',
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColor.black,
                    fontWeight: FontWeight.w900,),
                ),
                YMargin(context.height * 30 / AppConstants.designHeight),
                CustomAuthTextField(
                  controller: authViewModel.passwordController,
                  hintText: 'Password',
                  prefixImage: 'assets/icons/lock.svg',
                  obscureText: !passwordVisible,
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
                          confirmPasswordVisible = !confirmPasswordVisible;
                        },
                      );
                    },
                    child: Image.asset(confirmPasswordVisible == true
                        ? 'assets/images/unvisible.png'
                        : 'assets/images/visibility_off.png',),),
                  validator: (value){
                    if(authViewModel.passwordController.text.isEmpty){
                      return 'Please enter a password';
                    }else if((value ?? '').isEmpty){
                      return 'Please confirm your password';
                    } else if(authViewModel.passwordController.text != value){
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                CustomButton(
                  buttonText: 'Continue',
                  onTap: () async {
                    if(formKey.currentState?.validate() ?? false) {
                      final response = await authViewModel.signUpWithPhone();
                      if(response.isSuccessful && context.mounted){
                        unawaited(Navigator.pushNamed(context, AppRoute.phonenoLoginPage));
                        unawaited(CustomAlert.show(context, success: true, message: 'Account created successfully, please login'));
                      }else{
                        unawaited(CustomAlert.show(context, message: response.message ?? 'An error occurred'));
                      }
                    }
                  },
                ),
                YMargin(context.height * 50 / AppConstants.designHeight),
              ],),
            ),
          ),
        );
      },
    );
  }
}
