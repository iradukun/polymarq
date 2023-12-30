import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polymarq/technicians/home_screen/model/notification_model.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/home_view_model.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class NotificatonsScreen extends ConsumerStatefulWidget {
  const NotificatonsScreen({super.key});

  @override
  ConsumerState<NotificatonsScreen> createState() => _NotificatonsScreenState();
}

class _NotificatonsScreenState extends ConsumerState<NotificatonsScreen> {
  final ScrollController categoryScrollController = ScrollController();
  @override
  void initState() {
    categoryScrollController.addListener(() {
      if (categoryScrollController.position.pixels ==
          categoryScrollController.position.maxScrollExtent) {
        ref.read(getNotificationCategoryPage.notifier).state++;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getNotification = ref.watch(getNotificationToolProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: AppColor.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset('assets/icons/settings2.svg'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(context.height * 10 / AppConstants.designHeight),
          getNotification.when(
            data: (notify) {
              if (notify.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: context.height * 100 / AppConstants.designHeight,
                    ),
                    const Center(
                      child: Text(
                        'No notification available',
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
              return Expanded(
                child: ListView.builder(
                  itemCount: notify.length,
                  itemBuilder: (context, i) {
                    return NotificationTile(notificationModel: notify[i]);
                  },
                ),
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
    );
  }
}

class NotificationTile extends ConsumerWidget {
  const NotificationTile({
    required this.notificationModel,
    super.key,
  });
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.read(homeNotifier.notifier);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.height * 10 / AppConstants.designHeight,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightIris,
        border: Border(
          bottom: BorderSide(
            color: AppColor.blackGrey.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        leading: Image.asset('assets/images/user2.png'),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Text(
                notificationModel.title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: AppColor.blackGrey,
                ),
              ),
              XMargin(context.width * 5 / AppConstants.designWidth),
              Container(
                height: context.height * 5 / AppConstants.designHeight,
                width: context.height * 5 / AppConstants.designHeight,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.iris,
                ),
              ),
              XMargin(context.width * 5 / AppConstants.designWidth),
              Text(
                notificationModel.createdDisplay ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: AppColor.blackGrey,
                ),
              ),
            ],
          ),
        ),
        title: notificationModel.notificationType == 'TOOL-NEGOTIATION'
            ? Column(
                children: [
                  Text(
                    notificationModel.body ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColor.black,
                    ),
                  ),
                  const YMargin(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColor.iris,
                            borderRadius: BorderRadius.circular(10),),
                        child: Center(
                            child: Text(
                          '${notificationModel.payload?.price ?? ''} NGN',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColor.white,
                          ),
                        ),),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              homeViewModel
                                  .toolPurchaseResponse(
                                      uuid: notificationModel
                                              .payload!.negotiationUuid ??
                                          '',
                                      status: 'rejected',)
                                  .then((value) {
                                CustomAlert.show(
                                  context,
                                  message: value.message ?? '',
                                  success: value.isSuccessful,
                                );
                              });
                            },
                            child: SvgPicture.asset(
                              'assets/icons/delete.svg',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              homeViewModel
                                  .toolPurchaseResponse(
                                      uuid: notificationModel
                                              .payload!.negotiationUuid ??
                                          '',
                                      status: 'accepted',)
                                  .then((value) {
                                CustomAlert.show(
                                  context,
                                  message: value.message ?? '',
                                  success: value.isSuccessful,
                                );
                              });
                            },
                            child: SvgPicture.asset(
                              'assets/icons/checked.svg',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            : notificationModel.notificationType == 'TOOL-NEGOTIATION-RESPONSE'
                ? InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      // ))
                    },
                    child: Text(
                      notificationModel.body ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColor.black,
                      ),
                    ),
                  )
                : Text(
                    notificationModel.body ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColor.black,
                    ),
                  ),
      ),
    );
  }
}
