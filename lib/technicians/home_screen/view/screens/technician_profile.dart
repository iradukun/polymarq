import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/providers/storage.dart';
import 'package:polymarq/settings/viewmodels/settings_view_model.dart';
import 'package:polymarq/technicians/home_screen/view/widgets/recent_experiece.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/home_view_model.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/app_avatar.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class TechnicianProfile extends ConsumerStatefulWidget {
  const TechnicianProfile({super.key});

  @override
  ConsumerState<TechnicianProfile> createState() => _TechnicianProfileState();
}

class _TechnicianProfileState extends ConsumerState<TechnicianProfile> {
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.read(homeNotifier.notifier);
    final acceptedJobViewModel = ref.watch(getAcceptedJobProvider);
    final userViewModel = ref.watch(getUserProvider);
    return Scaffold(
      backgroundColor: AppColor.iris100,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColor.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                YMargin(context.height * 100 / AppConstants.designHeight),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      YMargin(
                        context.height * 55.5 / AppConstants.designHeight,
                      ),
                      userViewModel.when(
                        data: (users) {
                          return Column(
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
                              Text(
                                users.services ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: AppColor.black100,
                                ),
                              ),
                              Text(
                                '${users.city ?? ''} ${users.country ?? ''} ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: AppColor.blackGrey,
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () {
                          return const CircularProgressIndicator();
                        },
                        error: (e, stackTrace) {
                          return Text(e.toString());
                        },
                      ),
                      YMargin(context.height * 20 / AppConstants.designHeight),
                      Container(
                        height:
                            context.height * 100 / AppConstants.designHeight,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.iris100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: context.height *
                                  90 /
                                  AppConstants.designHeight,
                              width: context.width *
                                  170 /
                                  AppConstants.designWidth,
                              decoration: BoxDecoration(
                                color: AppColor.lightVirgo,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'EXPERIENCE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: AppColor.black100,
                                    ),
                                  ),
                                  Text(
                                    '10',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: AppColor.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            XMargin(
                              context.width * 8 / AppConstants.designWidth,
                            ),
                            Container(
                              height: context.height *
                                  90 /
                                  AppConstants.designHeight,
                              width: context.width *
                                  170 /
                                  AppConstants.designWidth,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3D9DA),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'VERIFIED',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: AppColor.black100,
                                    ),
                                  ),
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: AppColor.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Experience',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: AppColor.black,
                              ),
                            ),
                            Text(
                              'see all',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppColor.blackGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      acceptedJobViewModel.when(
                        data: (job) {
                          if (job.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: context.height *
                                      100 /
                                      AppConstants.designHeight,
                                ),
                                const Center(
                                  child: Text(
                                    'No job experience yet',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: job
                                  .map(
                                    (e) => RecentExperience(jobData: e),
                                  )
                                  .toList(),
                            );
                          }
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
              ],
            ),
            Positioned(
              top: context.height * 50 / AppConstants.designHeight,
              left: context.width * 160 / AppConstants.designWidth,
              child: SizedBox(
                height: context.height * 90 / 891,
                width: context.height * 90 / 891,
                child: AppAvatar(
                  radius: 20,
                  imgUrl: MyPref.profilePicture,
                ),
              ),
            ),

            // child: SizedBox(
            //   height: context.height  * 70 / 891,
            //   width: context.height  * 70 / 891,
            //   child: AppAvatar(
            //     radius: 20,
            //     imgUrl: MyPref.profilePicture,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
