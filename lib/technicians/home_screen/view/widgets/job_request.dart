// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:polymarq/technicians/home_screen/model/job_request_model.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/home_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class JobRequest extends ConsumerStatefulWidget {
  const JobRequest({
    required this.jobData,
    super.key,
    this.onAccept,
    this.onDecline,
  });
  final Function? onAccept;
  final Function? onDecline;
  final JobRequestModel jobData;

  @override
  ConsumerState<JobRequest> createState() => _JobRequestState();
}

class _JobRequestState extends ConsumerState<JobRequest> {
  final priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        height: context.height * 130 / AppConstants.designHeight,
        margin: EdgeInsets.symmetric(
          vertical: context.width * 5 / AppConstants.designWidth,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.height * 10 / AppConstants.designHeight,
          vertical: context.height * 10 / AppConstants.designHeight,
        ),
        decoration: BoxDecoration(
          color: AppColor.iris100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (widget.jobData.job?.image != null)
                      Container(
                        height: 55,
                        width: context.width * 60 / AppConstants.designWidth,
                        decoration: const BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.jobData.job!.image.toString(),
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
                          widget.jobData.job?.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColor.black,
                          ),
                        ),
                        YMargin(context.height * 3 / AppConstants.designHeight),
                        SizedBox(
                          width: context.width * 100 / AppConstants.designWidth,
                          child: Text(
                            widget.jobData.job?.description ??
                                'No description provided',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: AppColor.black100,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        YMargin(context.height * 3 / AppConstants.designHeight),
                        Text(
                          widget.jobData.job?.locationAddress ??
                              'Lagos, Nigeria',
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
                        widget.onDecline?.call();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/delete.svg',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onAccept?.call();
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
                  width: context.width * 60 / AppConstants.designWidth,
                  height: context.height * 30 / AppConstants.designHeight,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.jobData.job?.duration ?? 0} Days',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        color: AppColor.black100,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: context.width * 130 / AppConstants.designWidth,
                  height: context.height * 30 / AppConstants.designHeight,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.jobData.job?.minPrice} - ${widget.jobData.job?.maxPrice} ${widget.jobData.job?.maxPriceCurrency}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        color: AppColor.black100,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: context.width * 70 / AppConstants.designWidth,
                  height: context.height * 30 / AppConstants.designHeight,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.jobData.distanceFromClient ?? 0} Miles',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        // overflow: TextS,
                        color: AppColor.black100,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    negotiateDialog(context);
                  },
                  child: Container(
                    width: context.width * 80 / AppConstants.designWidth,
                    height: context.height * 30 / AppConstants.designHeight,
                    decoration: BoxDecoration(
                      color: AppColor.black100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Negotiate',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void negotiateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter your preferred price',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColor.black,
                ),
              ),
              const YMargin(20),
              CustomTextFieild(
                suffixImage: const SizedBox(),
                textName: '',
                borderColor: AppColor.whiteGrey,
                controller: priceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the hours needed';
                  }
                  return null;
                },
              ),
              const YMargin(30),
              CustomButton(
                buttonText: 'Submit',
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ref
                        .read(homeNotifier.notifier)
                        .acceptJob(
                          uuid: widget.jobData.uuid ?? '',
                          price: priceController.text,
                        )
                        .then((value) {
                      CustomAlert.show(
                        context,
                        message: value.message ?? '',
                        success: value.isSuccessful,
                      ).then((value) => Navigator.pop(context));
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
