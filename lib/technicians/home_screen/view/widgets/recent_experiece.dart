import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/technicians/home_screen/model/accepted_job_model.dart';
import 'package:polymarq/technicians/home_screen/view/widgets/review_widget.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class RecentExperience extends StatelessWidget {
  const RecentExperience({required this.jobData, super.key});
  final AcceptedJobModel jobData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: context.height * 124 / 891,
      margin: EdgeInsets.symmetric(
        vertical: context.height * 5 / 891,
        horizontal: context.width * 15 / 413,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.height * 10 / 891,
        vertical: context.width * 10 / 413,
      ),
      decoration: BoxDecoration(
        color: AppColor.iris100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (jobData.image != null)
                Container(
                  height: 55,
                  width: context.width * 60 / AppConstants.designWidth,
                  decoration: const BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: jobData.image.toString(),
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
              XMargin(context.width * 5 / 413),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobData.name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppColor.black,
                    ),
                  ),
                  YMargin(context.height * 3 / 891),
                  Text(
                    jobData.description ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: AppColor.black100,
                    ),
                  ),
                  YMargin(context.height * 3 / 891),
                  Text(
                    jobData.locationAddress ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: AppColor.blackGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          YMargin(context.height * 10 / 891),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: context.width * 100 / 413,
                height: context.height * 25 / 891,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    jobData.duration.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      color: AppColor.black100,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.grey,
                    barrierColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    context: context,
                    builder: (context) => ReviewWidget(jobData: jobData),
                    useSafeArea: true,
                    isScrollControlled: true,
                    useRootNavigator: true,
                  );
                },
                child: Container(
                  width: context.width * 100 / 413,
                  height: context.height * 25 / 891,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Review',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppColor.black100,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: context.width * 120 / 413,
                height: context.height * 25 / 891,
                decoration: BoxDecoration(
                  color: AppColor.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/status.svg'),
                    XMargin(context.width * 3 / 413),
                    Text(
                      jobData.status ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
