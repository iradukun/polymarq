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

class EmailForgetPasswordScreen extends StatelessWidget {
  const EmailForgetPasswordScreen({super.key});

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
                      "Don't worry! Please enter the email address associate\nto your account to verify.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    YMargin(context.height * 40 / AppConstants.designHeight),
                    CustomAuthTextField(
                      controller: authViewModel.emailController,
                      hintText: 'Enter Email Address',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if ((value ?? '').isEmail) {
                          return null;
                        }
                        return 'Please enter a valid email';
                      },
                    ),
                    YMargin(context.height * 50 / AppConstants.designHeight),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.phonenoForgotPasswordPage,
                          );
                        },
                        child: const Text(
                          'Use Phone Number Instead',
                          style: TextStyle(
                            color: AppColor.iris,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    YMargin(context.height * 300 / AppConstants.designHeight),
                    CustomButton(
                      buttonText: 'Continue',
                      onTap: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          await authViewModel.forgotPassword(context);
                          //    final response = await authViewModel.forgotPassword
                          // if(response.isSuccessful && context.mounted){
                          //   unawaited(CustomAlert.show(context, message: 'OTP verified successfully, please enter a new password'));
                          //   unawaited(Navigator.pushNamed(context, AppRoute.newPasswordPage));
                          // }else{
                          //   unawaited(CustomAlert.show(context, message: response.message ?? 'An error occurred'));
                          // }
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
