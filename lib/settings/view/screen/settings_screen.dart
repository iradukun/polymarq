import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/settings/viewmodels/settings_view_model.dart';
import 'package:polymarq/technicians/home_screen/view/screens/technician_profile.dart';
import 'package:polymarq/utils/app_avatar.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final settingsViewModel = ref.watch(settingsViewModelProvider);
        final userViewModel = ref.watch(getUserProvider);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColor.black,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: context.width * 20 / AppConstants.designWidth,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.searchPage,
                      );
                    },
                    child: SvgPicture.asset('assets/icons/search.svg'),
                  ),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(context.height * 10 / AppConstants.designHeight),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.width * 15 / AppConstants.designWidth,
                  ),
                  padding: EdgeInsets.all(
                    context.height * 10 / AppConstants.designHeight,
                  ),
                  height: context.height * 100 / AppConstants.designHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.iris100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: AppAvatar(
                          imgUrl: settingsViewModel.urlImageController.text,
                          imageFile: settingsViewModel.selectedImage,
                        ),
                      ),
                      const XMargin(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const YMargin(10),
                          userViewModel.when(
                            data: (users) {
                              return Text(
                                '${users.user?.firstName ?? ''} ${users.user?.lastName ?? ''} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                            loading: () {
                              return const CircularProgressIndicator();
                            },
                            error: (e, stackTrace) {
                              return Text(e.toString());
                            },
                          ),
                          const YMargin(5),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TechnicianProfile(),
                                ),
                              );
                            },
                            child: const Text(
                              'View Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: AppColor.blackGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                YMargin(context.height * 20 / AppConstants.designHeight),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 15 / AppConstants.designWidth,
                  ),
                  child: const Text(
                    'Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColor.blackGrey,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.personalInformationPage,
                    );
                  },
                  leading: SvgPicture.asset('assets/icons/personal.svg'),
                  title: const Text(
                    'Personal information',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.black,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.bankAccountPage,
                    );
                  },
                  leading: SvgPicture.asset('assets/icons/payment.svg'),
                  title: const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.black,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.linkedAccountPage,
                    );
                  },
                  leading: SvgPicture.asset('assets/icons/account.svg'),
                  title: const Text(
                    'Linked Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.black,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'General',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColor.blackGrey,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.notificationsPage,
                    );
                  },
                  leading: SvgPicture.asset('assets/icons/notify.svg'),
                  title: const Text(
                    'Notifications',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.black,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.applicationStatusPage,
                    );
                  },
                  leading: SvgPicture.asset('assets/icons/app_status.svg'),
                  title: const Text(
                    'Application Status',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.black,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.securityPage,
                    );
                  },
                  leading: SvgPicture.asset('assets/icons/security.svg'),
                  title: const Text(
                    'Security',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.black,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.languagePage,
                    );
                  },
                  leading: SvgPicture.asset('assets/icons/language.svg'),
                  title: const Text(
                    'Languages',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.black,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
                ListTile(
                  onTap: () {},
                  leading: SvgPicture.asset('assets/icons/help.svg'),
                  title: const Text(
                    'Helps Center',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.black,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.deleteAccountPage,
                    );
                  },
                  leading: SvgPicture.asset('assets/icons/delete_acct.svg'),
                  title: const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColor.red,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
