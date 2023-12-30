// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polymarq/settings/model/user_model.dart';
import 'package:polymarq/settings/viewmodels/settings_view_model.dart';
import 'package:polymarq/utils/app_avatar.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class PersonalInfomationScreen extends ConsumerStatefulWidget {
  final UserModel? userModel;
  const PersonalInfomationScreen({super.key, this.userModel});

  @override
  ConsumerState<PersonalInfomationScreen> createState() =>
      _PersonalInfomationScreenState();
}

class _PersonalInfomationScreenState
    extends ConsumerState<PersonalInfomationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settingsViewModel = ref.watch(settingsViewModelProvider);
      settingsViewModel.firstNameController.text =
          widget.userModel?.user?.firstName ?? '';

      settingsViewModel.lastNameController.text =
          widget.userModel?.user?.lastName ?? '';
      settingsViewModel.servicesController.text =
          widget.userModel?.services ?? '';
      settingsViewModel.lgaController.text =
          widget.userModel?.localGovernmentArea ?? '';

      settingsViewModel.countryController.text =
          widget.userModel?.country ?? '';
      settingsViewModel.cityController.text = widget.userModel?.city ?? '';
    });

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final settingsViewModel = ref.watch(settingsViewModelProvider);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text(
                'Personal Information',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColor.black,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 20 / AppConstants.designWidth,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///profile picture
                      const YMargin(20),
                      Stack(
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () async {
                                await settingsViewModel.pickImage();
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              child: SizedBox(
                                height: 90,
                                width: 90,
                                child: AppAvatar(
                                  imgUrl:
                                      settingsViewModel.urlImageController.text,
                                  imageFile: settingsViewModel.selectedImage,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            left: 180,
                            child: InkWell(
                              onTap: () async {
                                await settingsViewModel.pickImage();
                                // if (mounted) {
                                //   setState(() {
                                final imageUpdateResponse =
                                    await settingsViewModel
                                        .updateProfilePicture();
                                if (imageUpdateResponse.isSuccessful &&
                                    context.mounted) {
                                  Navigator.pop(context);
                                  unawaited(
                                    CustomAlert.show(
                                      context,
                                      message:
                                          'Profile picture updated successfully',
                                      success: true,
                                    ),
                                  );
                                } else {
                                  unawaited(
                                    CustomAlert.show(
                                      context,
                                      message: imageUpdateResponse.message ??
                                          'Unable to update profile picture, please try again later',
                                    ),
                                  );
                                }
                                // });}
                              },
                              child: SvgPicture.asset(
                                'assets/icons/edit.svg',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),

                      ///first name
                      const Text(
                        'First Name*',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.whiteGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const YMargin(10),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: '',
                        color: AppColor.black,
                        controller: settingsViewModel.firstNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const YMargin(20),

                      ///last name
                      const Text(
                        'Last Name*',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.whiteGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const YMargin(10),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: '',
                        color: AppColor.black,
                        controller: settingsViewModel.lastNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const YMargin(20),

                      ///services
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      const Text(
                        'Your Services Offered',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.whiteGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: '',
                        color: AppColor.black,
                        controller: settingsViewModel.servicesController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the services you offer';
                          }
                          return null;
                        },
                      ),

                      ///country
                      YMargin(context.height * 20 / AppConstants.designHeight),
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
                          left: context.width * 10 / AppConstants.designWidth,
                        ),
                        child: const Text(
                          'Country',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.whiteGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: '',
                        color: AppColor.black,
                        controller: settingsViewModel.countryController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your country';
                          }
                          return null;
                        },
                      ),

                      ///city
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      Padding(
                        padding:
                            EdgeInsets.only(left: context.width * 10 / 414),
                        child: const Text(
                          'City',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.whiteGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: '',
                        color: AppColor.black,
                        controller: settingsViewModel.cityController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),

                      ///lga
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      Padding(
                        padding:
                            EdgeInsets.only(left: context.width * 10 / 414),
                        child: const Text(
                          'Local Government Area (LGA)',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.whiteGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      CustomTextFieild(
                        suffixImage: Image.asset('assets/images/voice.png'),
                        textName: '',
                        color: AppColor.black,
                        controller: settingsViewModel.lgaController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your LGA';
                          }
                          return null;
                        },
                      ),
                      YMargin(context.height * 30 / AppConstants.designHeight),

                      ///save button
                      CustomButton(
                        buttonText: 'Save',
                        onTap: () async {
                          print('pro${settingsViewModel.selectedImage}');
                          if (formKey.currentState!.validate()) {
                            final response =
                                await settingsViewModel.updateProfile();
                            if (response.isSuccessful && context.mounted) {
                              Navigator.pop(context);
                              unawaited(
                                CustomAlert.show(
                                  context,
                                  message: 'Profile updated successfully',
                                  success: true,
                                ),
                              );
                            } else {
                              unawaited(
                                CustomAlert.show(
                                  context,
                                  message: response.message ??
                                      'Unable to update profile, please try again later',
                                ),
                              );
                            }
                          }
                        },
                      ),
                      YMargin(context.height * 30 / AppConstants.designHeight),
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
