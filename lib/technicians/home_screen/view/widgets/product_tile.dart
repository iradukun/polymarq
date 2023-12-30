import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/technicians/home_screen/model/all_tools_model.dart';
import 'package:polymarq/technicians/home_screen/view/screens/edit_tool_screen.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/home_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class ProductTile extends ConsumerStatefulWidget {
  const ProductTile({
    required this.model,
    super.key,
  });
  final AllToolsModel model;

  @override
  ConsumerState<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends ConsumerState<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.height * 10 / AppConstants.designHeight,
      ),
      child: Container(
        height: context.height * 120 / AppConstants.designHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.iris100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: context.width * 90 / AppConstants.designWidth,
                    margin: EdgeInsets.all(
                      context.height * 10 / AppConstants.designHeight,
                    ),
                    decoration: const BoxDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        imageUrl: widget.model.images!.isEmpty
                            ? 'https://polymarq-dev-media.s3.amazonaws.com/profile_pictures/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image_wylbQ2o.jpg'
                            : widget.model.images![0].image ?? '',
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(
                        context.height * 20 / AppConstants.designHeight,
                      ),
                      Text(
                        widget.model.name ?? '',
                        style: const TextStyle(
                          fontSize: 17,
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      YMargin(
                        context.height * 5 / AppConstants.designHeight,
                      ),
                      Text(
                        widget.model.description ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColor.black100,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: context.height * 55 / AppConstants.designHeight,
                  right: context.width * 10 / AppConstants.designWidth,
                ),
                child: PopupMenuButton<int>(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.black,
                  ),
                  shadowColor: AppColor.white,
                  surfaceTintColor: AppColor.white,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text(
                        'Edit tool informations',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColor.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text(
                        'Delete tool',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColor.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                  offset: const Offset(0, 100),
                  color: Colors.white,
                  elevation: 2,
                  onSelected: (value) {
                    if (value == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditToolScreen(
                            model: widget.model,
                          ),
                        ),
                      );
                    } else {
                      showDeleteDialog(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.white,
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: 'Yes',
                    onTap: () {
                      ref
                          .read(homeNotifier.notifier)
                          .deleteTools(uuid: widget.model.uuid ?? '')
                          .then((value) {
                        CustomAlert.show(
                          context,
                          message: value.isSuccessful == true
                              ? 'tool deleted successfully'
                              : value.message!,
                          success: value.isSuccessful,
                        );
                      });
                    },
                  ),
                ),
                const XMargin(10),
                Expanded(
                  child: CustomButton(
                    buttonText: 'No',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
          content: const Text(
            'Are you sure you want to\ndelete this tool',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppColor.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }
}
