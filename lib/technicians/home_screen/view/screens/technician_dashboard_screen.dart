import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polymarq/providers/storage.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/settings/view/screen/application_status.dart';
import 'package:polymarq/settings/view/screen/settings_screen.dart';
import 'package:polymarq/settings/viewmodels/settings_view_model.dart';
import 'package:polymarq/technicians/home_screen/view/screens/search_screen.dart';

import 'package:polymarq/technicians/home_screen/view/widgets/job_request.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/home_view_model.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';

import 'package:polymarq/utils/app_avatar.dart';

import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class TechnicianDashboard extends ConsumerStatefulWidget {
  const TechnicianDashboard({super.key});

  @override
  ConsumerState<TechnicianDashboard> createState() =>
      _TechnicianDashboardState();
}

class _TechnicianDashboardState extends ConsumerState<TechnicianDashboard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = ref.watch(settingsViewModelProvider);
    final homeViewModel = ref.read(homeNotifier.notifier);
    final userViewModel = ref.watch(getUserProvider);
    final jobViewModel = ref.watch(getJobRequestProvider);
    final myToolViewModel = ref.watch(getMyToolCountProvider);
    final otherToolViewModel = ref.watch(getOtherToolCountProvider);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.1,
                      height: context.width * 0.1,
                      child: AppAvatar(
                        imgUrl: MyPref.profilePicture,
                        imageFile: settingsViewModel.selectedImage,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.searchPage);
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: context.width * 15 / AppConstants.designWidth,
              ),
              child: SvgPicture.asset(
                'assets/icons/search.svg',
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.height * 30 / AppConstants.designHeight,
            horizontal: context.width * 20 / AppConstants.designWidth,
          ),
          child: Column(
            children: [
              YMargin(context.height * 22 / AppConstants.designHeight),
              Row(
                children: [
                  SizedBox(
                    width: context.width * 0.13,
                    height: context.width * 0.13,
                    child: AppAvatar(
                      imgUrl: MyPref.profilePicture,
                      imageFile: settingsViewModel.selectedImage,
                    ),
                  ),
                  const XMargin(5),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final user = MyPref.user;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userViewModel.when(
                              data: (users) {
                                return Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${users.user?.firstName ?? ''} ${users.user?.lastName ?? ''} ',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              loading: () {
                                return const CircularProgressIndicator();
                              },
                              error: (
                                e,
                                stackTrace,
                              ) {
                                return Text(e.toString());
                              },
                            ),
                            Text(
                              user?.email ?? '',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackGrey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // XMargin(context.width * 70 / AppConstants.designWidth),

                  const SizedBox(width: 5),
                  SvgPicture.asset('assets/icons/back_arrow.svg'),
                ],
              ),
              YMargin(context.height * 52 / AppConstants.designHeight),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(
                  'assets/icons/app_status.svg',
                ),
                title: const Text(
                  'Application Status',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: const Text(
                  'All Informations your ranging on Polymarq',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackGrey,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<ApplicationStatusScreen>(
                      builder: (context) => const ApplicationStatusScreen(),
                    ),
                  );
                },
              ),
              const Divider(
                color: AppColor.blackGrey,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset('assets/icons/settings.svg'),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<SettingsScreen>(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset('assets/icons/support.svg'),
                title: const Text(
                  'Help & Support',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  // SettingsScreen()));
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset('assets/icons/feedback.svg'),
                title: const Text(
                  'Feedback & Suggestions',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  //  Navigator.pop(context);
                },
              ),
              YMargin(context.height * 170 / AppConstants.designHeight),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset('assets/icons/logout.svg'),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  await MyPref.clearBoxes();
                  if (mounted) {
                    unawaited(
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoute.onboardingPage,
                        (route) => false,
                      ),
                    );
                  }
                  //  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(context.height * 10 / AppConstants.designHeight),
              const Text(
                'Reminder',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColor.black,
                ),
              ),
              YMargin(context.height * 10 / AppConstants.designHeight),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.scheduledPage);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 13 / AppConstants.designHeight,
                    horizontal: context.width * 13 / AppConstants.designWidth,
                  ),
                  width: double.infinity,
                  height: context.height * 258 / AppConstants.designHeight,
                  decoration: BoxDecoration(
                    color: AppColor.iris100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              context.height * 10 / AppConstants.designHeight,
                          horizontal:
                              context.width * 7 / AppConstants.designWidth,
                        ),
                        height: double.infinity,
                        width: context.width * 210 / AppConstants.designWidth,
                        decoration: BoxDecoration(
                          color: AppColor.iris,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: context.width *
                                      120 /
                                      AppConstants.designWidth,
                                  height: context.height *
                                      30 /
                                      AppConstants.designHeight,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.width *
                                        3 /
                                        AppConstants.designWidth,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Scheduled',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                            color: AppColor.blackGrey,
                                          ),
                                        ),
                                        XMargin(
                                          context.width *
                                              10 /
                                              AppConstants.designWidth,
                                        ),
                                        Container(
                                          width: context.height *
                                              20 /
                                              AppConstants.designHeight,
                                          height: context.height *
                                              20 /
                                              AppConstants.designHeight,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '7',
                                              style: TextStyle(
                                                color: AppColor.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/arrow.svg',
                                  width: context.width *
                                      30 /
                                      AppConstants.designWidth,
                                ),
                              ],
                            ),
                            YMargin(
                              context.height * 8 / AppConstants.designHeight,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: context.height *
                                        40 /
                                        AppConstants.designHeight,
                                  ),
                                  child: Image.asset(
                                    'assets/images/plumber.png',
                                  ),
                                ),
                                XMargin(
                                  context.width * 5 / AppConstants.designWidth,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Network Administration',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    const Text(
                                      'Lorem ipsum dolor sit amet\nEt culpa fuga ut iusto inven\nsit maxime voluptatem...',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 8,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    YMargin(
                                      context.height *
                                          2 /
                                          AppConstants.designHeight,
                                    ),
                                    const Text(
                                      'Wed, 10th July, 2023',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 9,
                                        color: AppColor.black100,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            YMargin(
                              context.height * 8 / AppConstants.designHeight,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: context.height *
                                        40 /
                                        AppConstants.designHeight,
                                  ),
                                  child: Image.asset(
                                    'assets/images/technician_dp.png',
                                  ),
                                ),
                                XMargin(
                                  context.width * 5 / AppConstants.designWidth,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Patrick Remold',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    const Text(
                                      'Lorem ipsum dolor sit amet\nEt culpa fuga ut iusto inven\nsit maxime voluptatem...',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    YMargin(
                                      context.height *
                                          2 /
                                          AppConstants.designHeight,
                                    ),
                                    const Text(
                                      'Wed, 10th July, 2023',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 9,
                                        color: AppColor.black100,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      XMargin(context.width * 4 / AppConstants.designWidth),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.productCategoriesPage,
                              );
                            },
                            child: Container(
                              height: context.height *
                                  105 /
                                  AppConstants.designHeight,
                              width: context.width *
                                  125 /
                                  AppConstants.designWidth,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              decoration: BoxDecoration(
                                color: AppColor.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/product.svg',
                                    width: context.width *
                                        30 /
                                        AppConstants.designWidth,
                                    height: context.height *
                                        25 /
                                        AppConstants.designHeight,
                                  ),
                                  YMargin(
                                    context.height *
                                        5 /
                                        AppConstants.designHeight,
                                  ),
                                  const Center(
                                    child: Text(
                                      'Products',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ),
                                  const YMargin(5),
                                  myToolViewModel.when(
                                    data: (myTool) {
                                      return Text(
                                        myTool.count! <= 1
                                            ? '${myTool.count ?? ''} Product Available'
                                            : '${myTool.count ?? ''} Products Available',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 8,
                                          color: AppColor.blackGrey,
                                        ),
                                      );
                                    },
                                    loading: () {
                                      return const Text('');
                                    },
                                    error: (
                                      e,
                                      stackTrace,
                                    ) {
                                      return Text(e.toString());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          YMargin(
                            context.height * 10 / AppConstants.designHeight,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.toolSharePage,
                              );
                            },
                            child: Container(
                              height: context.height *
                                  105 /
                                  AppConstants.designHeight,
                              width: context.width *
                                  125 /
                                  AppConstants.designWidth,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              decoration: BoxDecoration(
                                color: AppColor.peach,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/tools.svg',
                                    width: context.width *
                                        30 /
                                        AppConstants.designWidth,
                                    height: context.height *
                                        25 /
                                        AppConstants.designHeight,
                                  ),
                                  YMargin(
                                    context.height *
                                        5 /
                                        AppConstants.designHeight,
                                  ),
                                  const Center(
                                    child: Text(
                                      'Tool share',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ),
                                  const YMargin(5),
                                  otherToolViewModel.when(
                                    data: (otherTools) {
                                      return Text(
                                        otherTools.count! <= 1
                                            ? '${otherTools.count ?? ''} Product Available'
                                            : '${otherTools.count ?? ''} Products Available',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 8,
                                          color: AppColor.blackGrey,
                                        ),
                                      );
                                    },
                                    loading: () {
                                      return const Text('');
                                    },
                                    error: (
                                      e,
                                      stackTrace,
                                    ) {
                                      return Text(e.toString());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              YMargin(context.height * 10 / AppConstants.designHeight),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.shopToolsPage);
                },
                child: Container(
                  width: double.infinity,
                  height: context.height * 50 / AppConstants.designHeight,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.lightGrey,
                      width: context.width * 2 / AppConstants.designWidth,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 10 / AppConstants.designWidth,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/shoptools.svg'),
                        XMargin(context.width * 10 / AppConstants.designWidth),
                        const Text(
                          'SHOP TOOLS',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColor.black,
                          ),
                        ),
                        XMargin(context.width * 15 / AppConstants.designWidth),
                        Container(
                          width: context.width * 3 / AppConstants.designWidth,
                          height:
                              context.height * 30 / AppConstants.designHeight,
                          color: AppColor.lightGrey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              YMargin(context.height * 20 / AppConstants.designHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New jobs requests',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColor.black100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColor.whiteGrey,
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(context.height * 10 / AppConstants.designHeight),
              jobViewModel.when(
                data: (job) {
                  if (job.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height:
                              context.height * 100 / AppConstants.designHeight,
                        ),
                        const Center(
                          child: Text(
                            'No job request avaailable',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: job
                        .map(
                          (e) => JobRequest(
                            jobData: e,
                            onAccept: () {
                              homeViewModel
                                  .acceptJobWithoutPrice(uuid: e.uuid ?? '')
                                  .then((value) {
                                CustomAlert.show(
                                  context,
                                  message: value.message ?? '',
                                  success: value.isSuccessful,
                                );
                              });
                            },
                            onDecline: () {
                              homeViewModel
                                  .declineJob(e.uuid ?? '')
                                  .then((value) {
                                CustomAlert.show(
                                  context,
                                  message: value.message ?? '',
                                  success: value.isSuccessful,
                                );
                              });
                            },
                          ),
                        )
                        .toList(),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.iris,
                    ),
                  );
                },
                error: (e, stackTrace) {
                  return Text(e.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
