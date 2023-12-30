import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class ScheduledScreen extends StatefulWidget {
  const ScheduledScreen({super.key});

  @override
  State<ScheduledScreen> createState() => _ScheduledScreenState();
}

class _ScheduledScreenState extends State<ScheduledScreen> {
  int currentindex = 0;
  List<String> schedule = ['31', '1', '2', '3', '4', '5', '6', '7'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(
              right: context.width * 5 / AppConstants.designWidth,),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        title: const Text(
          'Scheduled',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: context.width * 15 / AppConstants.designWidth,),
            child: SvgPicture.asset('assets/icons/filter.svg'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: context.width * 15 / AppConstants.designWidth,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi, there👋',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColor.whiteGrey,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Your Scheduled Are',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColor.black,
                  ),
                ),
                const XMargin(10),
                Container(
                  width: context.height * 20 / AppConstants.designHeight,
                  height: context.height * 20 / AppConstants.designHeight,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '7',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            SizedBox(
              height: context.height * 100 / AppConstants.designHeight,
              child: ListView.builder(
                itemCount: schedule.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentindex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right: context.width * 8 / AppConstants.designWidth,),
                      height: context.height * 120 / AppConstants.designHeight,
                      width: context.width * 60 / AppConstants.designWidth,
                      decoration: BoxDecoration(
                        color: currentindex == index
                            ? AppColor.iris
                            : AppColor.iris100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              context.width * 10 / AppConstants.designWidth,
                        ),
                        child: Column(
                          children: [
                            Text(schedule[index]),
                            YMargin(context.height *
                                20 /
                                AppConstants.designHeight,),
                            const Text('5'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            const Text(
              'Your Tasks',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppColor.black,
              ),
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            Column(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.width * 5 / AppConstants.designWidth,
                  ),
                  child: Row(
                    children: [
                      const Column(
                        children: [
                          Text(
                            '08:30',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColor.black100,
                            ),
                          ),
                          Text(
                            'Am',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: AppColor.blackGrey,
                            ),
                          ),
                        ],
                      ),
                      const XMargin(5),
                      SvgPicture.asset('assets/icons/green_circle.svg'),
                      Container(
                        height: context.height * 3 / AppConstants.designHeight,
                        width: context.width * 15 / AppConstants.designWidth,
                        color: AppColor.lightGrey,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height:
                            context.height * 130 / AppConstants.designHeight,
                        width: context.width * 290 / AppConstants.designWidth,
                        decoration: BoxDecoration(
                          color: AppColor.iris100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                            
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/plumber.png',
                                  width: context.height *
                                      30 /
                                      AppConstants.designHeight,
                                  height: context.height *
                                      30 /
                                      AppConstants.designHeight,
                                ),
                                XMargin(context.width *
                                    5 /
                                    AppConstants.designWidth,),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Plumber',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    Text(
                                      'Carmag.ng',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: AppColor.black100,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                // XMargin(context.width *
                                //     60 /
                                //     AppConstants.designWidth),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: context.width *
                                          10 /
                                          AppConstants.designWidth,),
                                  height: context.height *
                                      40 /
                                      AppConstants.designHeight,
                                  width: context.height *
                                      40 /
                                      AppConstants.designHeight,
                                  decoration: const BoxDecoration(
                                    color: AppColor.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/verts.svg',
                                    width: context.height *
                                        25 /
                                        AppConstants.designHeight,
                                    height: context.height *
                                        25 /
                                        AppConstants.designHeight,
                                  ),
                                ),
                              ],
                            ),
                            YMargin(
                                context.height * 5 / AppConstants.designHeight,),
                            const Text(
                              'Requirements: Bachelor degree  in\nminimum 5 Certifications in Elec....',
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: AppColor.blackGrey,
                              ),
                            ),
                            YMargin(
                                context.height * 5 / AppConstants.designHeight,),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/location.svg',
                                  width: context.height *
                                      15 /
                                      AppConstants.designHeight,
                                  height: context.height *
                                      15 /
                                      AppConstants.designHeight,
                                ),
                                XMargin(context.width *
                                    5 /
                                    AppConstants.designWidth,),
                                const Text(
                                  'Lagos, Nigeria',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: AppColor.iris,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: context.height * 3 / AppConstants.designHeight,
                        width: context.width * 15 / AppConstants.designWidth,
                        color: AppColor.lightGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
