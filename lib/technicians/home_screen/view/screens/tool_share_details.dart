import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/technicians/home_screen/model/tool_model.dart';
import 'package:polymarq/technicians/home_screen/view_model/home_state/home_state.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/home_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ToolShareDetailsScreen extends ConsumerStatefulWidget {
  const ToolShareDetailsScreen({required this.allToolsModel, super.key});
  final Tool allToolsModel;

  @override
  ConsumerState<ToolShareDetailsScreen> createState() =>
      _ToolShareDetailsScreenState();
}

class _ToolShareDetailsScreenState
    extends ConsumerState<ToolShareDetailsScreen> {
  PageController pageController = PageController();
  final _durationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int indicatorIndex = 1;
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(homeNotifier, (prev, next) {
      if (next is RentToolFailure) {
        CustomAlert.show(context, message: next.message);
      }
      if (next is RentToolSuccess) {
        CustomAlert.show(
          context,
          message: 'Tool rented Successfully',
          success: true,
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, AppRoute.technicianDashboard);
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.allToolsModel.name ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.width * 15 / AppConstants.designWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // YMargin(context.height * 30 / AppConstants.designHeight),
                  SizedBox(
                    height: context.height * 320 / AppConstants.designHeight,
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          indicatorIndex = index + 1;
                        });
                      },
                      itemCount: widget.allToolsModel.images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: context.height * 120 / 891,
                          width: context.width * 120 / 413,
                          margin: EdgeInsets.symmetric(
                            horizontal: context.width * 5 / 413,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.lightBlue,
                              width: context.width * 3 / 413,
                            ),
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.width * 10 / 413,
                              vertical: context.height * 15 / 891,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: double.infinity,
                                imageUrl:
                                    widget.allToolsModel.images[index].image,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  YMargin(context.height * 10 / AppConstants.designHeight),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: SlideEffect(
                        activeDotColor: AppColor.iris,
                        radius: 4,
                        dotWidth: context.width * 24 / AppConstants.designWidth,
                        dotHeight:
                            context.height * 8 / AppConstants.designHeight,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: AppColor.iris,
                      ),
                      onDotClicked: (index) {
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ),
                  YMargin(context.height * 10 / AppConstants.designHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.allToolsModel.price ?? 0}\$',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        height: context.height * 25 / 891,
                        width: context.width * 100 / 413,
                        decoration: BoxDecoration(
                          color: widget.allToolsModel.negotiable == true
                              ? AppColor.lightGreen
                              : AppColor.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              if (widget.allToolsModel.negotiable == true)
                                SvgPicture.asset('assets/icons/negotiate.svg')
                              else
                                SvgPicture.asset(
                                  'assets/icons/non_negotiate.svg',
                                ),
                              XMargin(context.width * 4 / 413),
                              Text(
                                widget.allToolsModel.negotiable == true
                                    ? 'Negotiable'
                                    : 'No negotaiable',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 8,
                                  color: AppColor.iris,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(context.height * 10 / AppConstants.designHeight),
                  Text(
                    widget.allToolsModel.name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColor.black,
                    ),
                  ),
                  YMargin(context.height * 10 / AppConstants.designHeight),
                  Row(
                    children: [
                      const Text(
                        '3.7',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColor.black,
                        ),
                      ),
                      XMargin(context.width * 3 / AppConstants.designWidth),
                      SvgPicture.asset('assets/icons/white.svg'),
                    ],
                  ),
                  YMargin(context.height * 10 / AppConstants.designHeight),

                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: widget.allToolsModel.colorCodes!
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: fromHex(e),
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  //  const Text(
                  //           'White',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 12,
                  //             color: AppColor.blackGrey,
                  //           ),
                  //         ),
                  YMargin(context.height * 20 / AppConstants.designHeight),
                  Text(
                    widget.allToolsModel.description ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: AppColor.blackGrey,
                    ),
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
                            height:
                                context.height * 20 / AppConstants.designHeight,
                            width:
                                context.height * 20 / AppConstants.designHeight,
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
                            height: 2,
                            width:
                                context.width * 265 / AppConstants.designWidth,
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
                  YMargin(context.height * 20 / AppConstants.designHeight),
                  CustomTextFieild(
                    suffixImage: const SizedBox(),
                    textName: 'Hours needed',
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the hours needed';
                      }
                      return null;
                    },
                  ),
                  YMargin(context.height * 20 / AppConstants.designHeight),
                  CustomButton(
                    buttonText: 'Request Tool',
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ref.read(homeNotifier.notifier).rentTools(
                              id: widget.allToolsModel.uuid,
                              duration: int.parse(_durationController.text),
                              price: widget.allToolsModel.price,
                            );
                      }
                    },
                  ),
                  const YMargin(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
