import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:polymarq/technicians/home_screen/model/job_request_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({required this.jobData, super.key});
  final JobRequestModel jobData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              YMargin(context.height * 10 / AppConstants.designHeight),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  XMargin(context.width * 90 / AppConstants.designWidth),
                  const Text(
                    'Job Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 15 / AppConstants.designWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YMargin(context.height * 20 / AppConstants.designHeight),
                    Row(
                      children: [
                        if (jobData.job?.image != null)
                          Container(
                            height: 55,
                            width:
                                context.width * 60 / AppConstants.designWidth,
                            decoration: const BoxDecoration(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: jobData.job!.image.toString(),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          )
                        else
                          Container(
                            height: 55,
                            width:
                                context.width * 60 / AppConstants.designWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/no_photo.jpg'),
                              ),
                            ),
                          ),
                        XMargin(context.width * 5 / AppConstants.designWidth),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jobData.job?.name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColor.black,
                              ),
                            ),
                            XMargin(
                              context.width * 3 / AppConstants.designWidth,
                            ),
                            Text(
                              jobData.job?.description ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: AppColor.black100,
                              ),
                            ),
                            XMargin(
                              context.width * 3 / AppConstants.designWidth,
                            ),
                            Text(
                              jobData.job?.locationAddress ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppColor.blackGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    YMargin(context.height * 20 / AppConstants.designHeight),
                    Container(
                      height: context.height * 120 / AppConstants.designHeight,
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            context.width * 10 / AppConstants.designHeight,
                        vertical:
                            context.height * 10 / AppConstants.designHeight,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.iris100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height:
                                context.height * 90 / AppConstants.designHeight,
                            width:
                                context.width * 165 / AppConstants.designWidth,
                            decoration: BoxDecoration(
                              color: AppColor.virgo,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Salary',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: AppColor.black100,
                                  ),
                                ),
                                Text(
                                  '${jobData.job!.minPrice}\$/hour',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: AppColor.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          XMargin(
                            context.width * 7 / AppConstants.designWidth,
                          ),
                          Container(
                            height:
                                context.height * 90 / AppConstants.designHeight,
                            width:
                                context.width * 165 / AppConstants.designWidth,
                            decoration: BoxDecoration(
                              color: AppColor.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Job Duration',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: AppColor.black100,
                                  ),
                                ),
                                Text(
                                  jobData.job!.duration.toString(),
                                  style: const TextStyle(
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
                    const Row(
                      children: [
                        Text(
                          'Job Descriptions',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: AppColor.black,
                          ),
                        ),
                      ],
                    ),
                    YMargin(context.height * 15 / AppConstants.designHeight),
                    Text(
                      jobData.job?.description ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColor.blackGrey,
                      ),
                    ),
                    YMargin(
                      context.height * 20 / AppConstants.designHeight,
                    ),
                    YMargin(context.height * 20 / AppConstants.designHeight),
                    Container(
                      width: double.infinity,
                      height: context.height * 50 / AppConstants.designHeight,
                      decoration: BoxDecoration(
                        color: AppColor.iris100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              context.width * 10 / AppConstants.designWidth,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: context.height *
                                  20 /
                                  AppConstants.designHeight,
                              width: context.height *
                                  20 /
                                  AppConstants.designHeight,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.iris,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  size: context.height *
                                      15 /
                                      AppConstants.designHeight,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                            XMargin(
                              context.width * 10 / AppConstants.designWidth,
                            ),
                            Container(
                              color: AppColor.iris,
                              height: context.height *
                                  2 /
                                  AppConstants.designHeight,
                              width: context.width *
                                  265 /
                                  AppConstants.designWidth,
                            ),
                            XMargin(
                              context.width * 10 / AppConstants.designWidth,
                            ),
                            const Text(
                              '13:34',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: AppColor.blackGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (jobData.job?.image != null)
                      Container(
                        height: 505,
                        width: context.width,
                        decoration: const BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: jobData.job!.image.toString(),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )
                    else
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                          // image: const DecorationImage(

                          //   image: AssetImage('assets/images/no_photo.jpg'),
                          // ),
                        ),
                        child: Image.asset(
                          'assets/images/no_photo.jpg',
                          width: double.infinity,
                        ),
                      ),
                    const YMargin(10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonText: 'Accept',
                            onTap: () {},
                            color: AppColor.iris,
                          ),
                        ),
                        const XMargin(20),
                        Expanded(
                          child: CustomButton(
                            buttonText: 'Decline',
                            onTap: () {},
                            color: AppColor.red,
                          ),
                        ),
                      ],
                    ),
                    const YMargin(20),
                    CustomButton(
                      buttonText: 'Negotiate',
                      onTap: () {},
                      color: AppColor.black100,
                    ),
                    const YMargin(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
