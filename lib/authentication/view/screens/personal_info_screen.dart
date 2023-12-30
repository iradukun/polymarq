// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/authentication/view_models/auth_view_model.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Consumer(
      builder: (context, ref, child) {
        final authViewModel = ref.watch(authViewModelProvider);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width * 20 / AppConstants.designWidth,),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      const Center(
                        child: Text(
                          'Personal Info',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColor.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      const Text(
                        'Your First Name*',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: 'Enter first name*',
                        controller: authViewModel.firstNameController,
                        validator: (value) {
                          if ((value ?? '').isNotEmpty) {
                            return null;
                          }
                          return 'Please enter your first name';
                        },
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      const Text(
                        'Your Last Name*',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: 'Enter last name*',
                        controller: authViewModel.lastNameController,
                        validator: (value) {
                          if ((value ?? '').isNotEmpty) {
                            return null;
                          }
                          return 'Please enter your last name';
                        },
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      const Text(
                        'Your Services Offered *',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: 'Type your services*',
                        controller: authViewModel.servicesOfferedController,
                        validator: (value) {
                          if ((value ?? '').isNotEmpty) {
                            return null;
                          }
                          return 'Please enter your services';
                        },
                      ),
                      YMargin(context.height * 30 / AppConstants.designHeight),
                      const Text(
                        'Address *',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                context.width * 10 / AppConstants.designWidth,),
                        child: const Text(
                          'Country',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.blackGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: 'Provide your Country*',
                        controller: authViewModel.countryController,
                        validator: (value) {
                          if ((value ?? '').isNotEmpty) {
                            return null;
                          }
                          return 'Please enter your country';
                        },
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                context.width * 10 / AppConstants.designWidth,),
                        child: const Text(
                          'City',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.blackGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: 'Enter your Work city Here',
                        controller: authViewModel.cityController,
                        validator: (value) {
                          if ((value ?? '').isNotEmpty) {
                            return null;
                          }
                          return 'Please enter your city';
                        },
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                context.width * 10 / AppConstants.designWidth,),
                        child: const Text(
                          'local govt area (LGA)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackGrey,
                          ),
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: 'Enter Your Work District Here',
                        controller: authViewModel.lgaController,
                        validator: (value) {
                          if ((value ?? '').isNotEmpty) {
                            return null;
                          }
                          return 'Please enter your LGA';
                        },
                      ),
                      YMargin(context.height * 80 / AppConstants.designHeight),
                      CustomButton(
                        buttonText: 'Next',
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            Navigator.pushNamed(
                              context,
                              AppRoute.workInfoPage,
                            );
                          }
                        },
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
