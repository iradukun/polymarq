import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/technicians/home_screen/model/job_request_model.dart';
import 'package:polymarq/technicians/home_screen/view/screens/job_details_screen.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class SearchTile extends ConsumerWidget {
  SearchTile({
    required this.jobData,
    super.key,
    this.onAccept,
    this.onDecline,
  });

  final Function? onAccept;
  final Function? onDecline;
  final JobRequestModel jobData;
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailsScreen(jobData: jobData),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        // height: context.height * 235 / AppConstants.designHeight,
        margin: EdgeInsets.symmetric(
          vertical: context.height * 10 / AppConstants.designHeight,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 10 / AppConstants.designWidth,
          vertical: context.height * 10 / AppConstants.designHeight,
        ),
        decoration: BoxDecoration(
          color: AppColor.iris100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                  if (jobData.job?.image != null)
                      Container(
                        height: 55,
                        width: context.width * 60 / AppConstants.designWidth,
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
                        width: context.width * 60 / AppConstants.designWidth,
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
                            fontSize: 15,
                            color: AppColor.black,
                          ),
                        ),
                        YMargin(context.height * 3 / AppConstants.designHeight),
                        Text(
                          jobData.job?.description ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: AppColor.black100,
                          ),
                        ),
                        const YMargin(3),
                        Text(
                          jobData.job?.locationAddress ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: AppColor.blackGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        onDecline?.call();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/delete.svg',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        onAccept?.call();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/checked.svg',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            YMargin(context.height * 13 / AppConstants.designHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: context.width * 70 / AppConstants.designWidth,
                  height: context.height * 30 / AppConstants.designHeight,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${jobData.job?.duration ?? 0} Days',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.black100,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: context.width * 150 / AppConstants.designWidth,
                  height: context.height * 30 / AppConstants.designHeight,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${jobData.job?.minPrice} - ${jobData.job?.maxPrice} ${jobData.job?.maxPriceCurrency}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppColor.black100,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: context.width * 100 / AppConstants.designWidth,
                  height: context.height * 30 / AppConstants.designHeight,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${jobData.distanceFromClient} Miles',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        color: AppColor.black100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            YMargin(context.height * 5 / AppConstants.designHeight),
            const Text(
              'Requirements: Bachelor degree  in Electronic, minimum 5 Certifications in Electronic and practiced the skill At a certified Company with polymarq...',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColor.blackGrey,
              ),
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            Container(
              height: 0.5,
              color: AppColor.black,
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Row(
                //   children: [
                //     Text(
                //       jobData.statusText,
                //       style: const TextStyle(
                //         fontWeight: FontWeight.w500,
                //         fontSize: 12,
                //         color: AppColor.black100,
                //       ),
                //     ),
                //     SvgPicture.asset(
                //       jobData.status,
                //       width: context.height * 15 / 891,
                //       height: context.height * 15 / 891,
                //     ),
                //   ],
                // ),
                Text(
                  '12min ago',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColor.blackGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
