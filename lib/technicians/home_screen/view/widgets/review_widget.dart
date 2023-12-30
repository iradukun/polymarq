import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/technicians/home_screen/model/accepted_job_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class ReviewWidget extends ConsumerWidget {
  const ReviewWidget({
    required this.jobData,
    super.key,
  });
  final AcceptedJobModel jobData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: context.height * 483 / 891,
      // width: w,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: context.height * 433 / 891,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            padding:
                EdgeInsets.symmetric(horizontal: context.height * 20 / 891),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.height * 80 / 891),
                Center(
                  child: Text(
                    '${jobData.client?.user?.firstName ?? ''} ${jobData.client?.user?.lastName ?? ''} ',
                    style: TextStyle(
                      fontSize: context.height * 20 / 891,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Work: ',
                      style: const TextStyle(
                        color: AppColor.iris,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: jobData.name ?? '',
                          style: const TextStyle(
                            color: AppColor.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const YMargin(5),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Location: ',
                      style: const TextStyle(
                        color: AppColor.iris,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: jobData.locationAddress ?? '',
                          style: const TextStyle(
                            color: AppColor.blackGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const YMargin(20),
                Text(
                  'Client says',
                  style: TextStyle(
                    fontSize: context.height * 20 / 891,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: context.width * 140 / 413,
            child: Container(
              height: context.height * 140 / 891,
              width: context.height * 150 / 891,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.accent,
              ),
              child: Column(
                children: [
                  if (jobData.client?.user?.profilePicture != null)
                    Container(
                      height: context.height * 80 / 891,
                      width: context.height * 80 / 891,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            jobData.client?.user?.profilePicture.toString() ??
                                '',
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      height: context.height * 80 / 891,
                      width: context.height * 80 / 891,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/no_photo.jpg'),
                        ),
                      ),
                    ),
                  const YMargin(10),
                  Text(
                    jobData.name ?? '',
                    style: const TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
