// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/authentication/view_models/auth_view_model.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class WorkInfoScreen extends StatelessWidget {
  const WorkInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Consumer(
      builder: (context, ref, child) {
        final authViewModel = ref.watch(authViewModelProvider);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            scrolledUnderElevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(
                left: context.width * 18 / AppConstants.designWidth,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            title: const Text(
              'Work Information',
              style: TextStyle(
                fontSize: 20,
                color: AppColor.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // YMargin(context.height * 20 / AppConstants.designHeight),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                context.width * 20 / AppConstants.designWidth,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //   const YMargin(20),
                              const Text(
                                'Select your work',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              YMargin(
                                context.height * 10 / AppConstants.designHeight,
                              ),
                              CustomTextFieild(
                                suffixImage: Image.asset(
                                  'assets/images/voice.png',
                                ),
                                textName: 'Job',
                                controller: authViewModel.work,
                                validator: (value) {
                                  if ((value ?? '').trim().isEmpty) {
                                    return 'Please enter your work';
                                  }
                                  return null;
                                },
                              ),
                              YMargin(
                                context.height * 20 / AppConstants.designHeight,
                              ),
                              const Text(
                                'Intro ( Work Description, Service Offered service Area )*',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              YMargin(
                                context.height * 10 / AppConstants.designHeight,
                              ),
                              CustomTextFieild(
                                suffixImage: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: context.height *
                                        40 /
                                        AppConstants.designHeight,
                                  ),
                                  child: Image.asset('assets/images/voice.png'),
                                ),
                                textName: 'Description',
                                maxLines: 3,
                                height: context.height *
                                    100 /
                                    AppConstants.designHeight,
                                controller: authViewModel.workDescription,
                                validator: (value) {
                                  if ((value ?? '').trim().isEmpty) {
                                    return 'Please enter your work description';
                                  }
                                  return null;
                                },
                              ),
                              YMargin(
                                context.height * 20 / AppConstants.designHeight,
                              ),
                              const Text(
                                'Your services offered*',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              YMargin(
                                context.height * 10 / AppConstants.designHeight,
                              ),
                              CustomTextFieild(
                                suffixImage:
                                    Image.asset('assets/images/voice.png'),
                                textName: 'Type your services*',
                                controller: authViewModel.servicesOffered,
                                validator: (value) {
                                  if ((value ?? '').trim().isEmpty) {
                                    return 'Please enter your the services you offer';
                                  }
                                  return null;
                                },
                              ),
                              YMargin(
                                context.height * 20 / AppConstants.designHeight,
                              ),
                              const Text(
                                'Your Work Address *',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              YMargin(
                                context.height * 10 / AppConstants.designHeight,
                              ),
                              CustomTextFieild(
                                controller: authViewModel.workAddress,
                                suffixImage:
                                    Image.asset('assets/images/voice.png'),
                                textName: 'Type your Address',
                                validator: (value) {
                                  if ((value ?? '').trim().isEmpty) {
                                    return 'Please enter your address';
                                  }
                                  return null;
                                },
                              ),
                              YMargin(
                                context.height * 20 / AppConstants.designHeight,
                              ),
                              const Text(
                                'Certificate degree ( PNG, PDF, WORD )*',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              YMargin(
                                context.height * 10 / AppConstants.designHeight,
                              ),
                              CustomTextFieild(
                                controller:
                                    authViewModel.selectedCertificateController,
                                suffixImage: InkWell(
                                  onTap: () async {
                                    final result =
                                        await FilePicker.platform.pickFiles();
                                    if (result != null) {
                                      if (result.files.single.path != null) {
                                        final file = File(
                                            result.files.single.path ?? '',);
                                        authViewModel.selectedCertificate =
                                            File(
                                                result.files.single.path ?? '',);
                                        authViewModel
                                            .selectedCertificateController
                                            .text = file.path.split('/').last;
                                      }
                                    }
                                  },
                                  child:
                                      Image.asset('assets/images/download.png'),
                                ),
                                textName: 'Select File',
                                validator: (value) {
                                  if ((value ?? '').trim().isEmpty) {
                                    return 'Please select a file';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                onTap: () async {
                                  final result =
                                      await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    if (result.files.single.path != null) {
                                      final file =
                                          File(result.files.single.path ?? '');
                                      authViewModel.selectedCertificate =
                                          File(result.files.single.path ?? '');
                                      authViewModel
                                          .selectedCertificateController
                                          .text = file.path.split('/').last;
                                    }
                                  }
                                },
                              ),
                              YMargin(
                                context.height * 10 / AppConstants.designHeight,
                              ),
                              const Text(
                                '( The verification of your Uploaded Certificate takes 24h )',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.iris,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              YMargin(
                                context.height * 40 / AppConstants.designHeight,
                              ),
                              CustomButton(
                                buttonText: 'Submit',
                                onTap: () async {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    final response =
                                        await authViewModel.completeSignUP();
                                    if (response.isSuccessful &&
                                        context.mounted) {
                                      await Navigator.pushNamed(
                                        context,
                                        AppRoute.authPaymentPage,
                                      );
                                      unawaited(
                                        CustomAlert.show(
                                          context,
                                          success: true,
                                          message:
                                              'Profile updated successfully',
                                        ),
                                      );
                                    } else {
                                      unawaited(
                                        CustomAlert.show(
                                          context,
                                          message: response.message ??
                                              'An error occurred',
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                              YMargin(
                                context.height * 50 / AppConstants.designHeight,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget technicianTools(TechnicianTools techs, BuildContext context) {
    return Container(
      height: context.height * 30 / AppConstants.designHeight,
      padding: EdgeInsets.symmetric(
        horizontal: context.height * 5 / AppConstants.designHeight,
        vertical: context.width * 5 / AppConstants.designWidth,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.whiteGrey,
      ),
      child: Text(
        techs.tools,
        style:
            const TextStyle(color: AppColor.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class TechnicianTools {
  final String tools;

  TechnicianTools({required this.tools});
}

List<TechnicianTools> tech = [
  TechnicianTools(tools: 'Screw'),
  TechnicianTools(tools: 'Spanner'),
  TechnicianTools(tools: 'Driverhhhh'),
  TechnicianTools(tools: 'Hammerbbb'),
  TechnicianTools(tools: 'Screw'),
  TechnicianTools(tools: 'Spanner'),
  TechnicianTools(tools: 'Driver'),
  TechnicianTools(tools: 'Hammer'),
];
