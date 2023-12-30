import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/authentication/view_models/auth_view_model.dart';
import 'package:polymarq/routes/app_route.dart';

import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authViewModel = ref.watch(authViewModelProvider);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xFF6C63FF),
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  CustomPaint(
                    painter: BlueWavePainter(),
                    child: Container(),
                  ),
                  Column(children: [
                    YMargin(context.height * 20 / AppConstants.designHeight),
                    SvgPicture.asset(
                      'assets/icons/logo.svg',
                      width: context.width * 100 / AppConstants.designWidth,
                    ),
                    YMargin(context.height * 20 / AppConstants.designHeight),
                    SvgPicture.asset(
                      'assets/icons/technician.svg',
                      width: context.width * 280 / AppConstants.designWidth,
                    ),
                    YMargin(context.height * 44 / AppConstants.designHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/inbox.svg'),
                        XMargin(context.width * 10 / AppConstants.designWidth),
                        InkWell(
                          onTap: () {
                            authViewModel.clearAllControllers();
                            Navigator.pushNamed(context, AppRoute.emailSignupPage);
                          },
                          child: const Text(
                            'Continue with Email Address',
                            style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    YMargin(context.height * 10 / AppConstants.designHeight),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: AppColor.lightGrey,
                      ),
                    ),
                    YMargin(context.height * 16 / AppConstants.designHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/call.svg'),
                        YMargin(context.height * 10 / AppConstants.designHeight),
                        InkWell(
                          onTap: () {
                            authViewModel.clearAllControllers();
                            Navigator.pushNamed(context, AppRoute.phonenoSignupPage);
                          },
                          child: const Text(
                            'Continue with Phone Number',
                            style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    YMargin(context.height * 10 / AppConstants.designHeight),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 30 / AppConstants.designWidth,),
                      child: const Divider(
                        color: AppColor.lightGrey,
                      ),
                    ),
                  ],),
                  YMargin(context.height * 20 / AppConstants.designHeight),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: context.height * 20 / AppConstants.designHeight),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Joined us before? ',
                          style: const TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  authViewModel.clearAllControllers();
                                  Navigator.pushNamed(context, AppRoute.phonenoLoginPage);
                                },
                              text: '  Login',
                              style: const TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,),),
                          ],),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


class BlueWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF6C63FF);

    final path = Path()
    ..moveTo(0, size.height)
    ..addRect(Rect.fromLTRB(0, size.height * 0.75, size.width, size.height))
    ..quadraticBezierTo(size.width * 0.25, size.height * 0.65, size.width * 0.45, size.height * 0.75)
    ..quadraticBezierTo(size.width * 0.65, size.height * 0.85, size.width, size.height * 0.75)
    ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


