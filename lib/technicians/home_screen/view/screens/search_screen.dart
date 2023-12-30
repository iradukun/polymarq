import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:polymarq/technicians/home_screen/view/widgets/search_tile.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/home_view_model.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.read(homeNotifier.notifier);
    final jobViewModel = ref.watch(getJobRequestProvider);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 15 / AppConstants.designWidth,
        ),
        child: Column(
          children: [
            YMargin(context.height * 50 / AppConstants.designHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.width * 300 / AppConstants.designWidth,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Electronic repair',
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical:
                            context.height * 10 / AppConstants.designHeight,
                        horizontal:
                            context.width * 10 / AppConstants.designWidth,
                      ),
                      fillColor: AppColor.iris100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset('assets/icons/filter.svg'),
              ],
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search Result',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  '32 Jobs Found',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColor.blackGrey,
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
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: job.length,
                      itemBuilder: (context, i) {
                        return SearchTile(
                          jobData: job[i],
                          onAccept: () {
                            homeViewModel
                                .acceptJobWithoutPrice(uuid: job[i].uuid ?? '')
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
                                .declineJob(job[i].uuid ?? '')
                                .then((value) {
                              CustomAlert.show(
                                context,
                                message: value.message ?? '',
                                success: value.isSuccessful,
                              );
                            });
                          },
                        );
                      },
                    ),
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
    );
  }
}
