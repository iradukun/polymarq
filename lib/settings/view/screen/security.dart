import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool isValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Security',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width * 5 / AppConstants.designWidth,),
        child: Column(
          children: [
            ListTile(
              leading: const Text(
                'General Notifications',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: CupertinoSwitch(
                activeColor: AppColor.iris,
                trackColor: AppColor.black200,
                thumbColor: AppColor.white,
                value: isValue,
                // provider.user!.browserNotification!,
                onChanged: (value) {
                  setState(() {
                    setState(() {
                      isValue = value;
                    });
                  });
                },
              ),
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            ListTile(
              leading: const Text(
                'Sound and Voice Settings',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: CupertinoSwitch(
                activeColor: AppColor.iris,
                trackColor: AppColor.black200,
                thumbColor: AppColor.white,
                value: isValue,
                // provider.user!.browserNotification!,
                onChanged: (value) {
                  setState(() {
                    setState(() {
                      isValue = value;
                    });
                  });
                },
              ),
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            ListTile(
              leading: const Text(
                'Change PIN',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.changePasswordEmailPage,
                );
              },
              child: ListTile(
                leading: const Text(
                  'Change Password with Email',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
              ),
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.changePasswordPhoneNoPage,
                );
              },
              child: ListTile(
                leading: const Text(
                  'Change Password with Phone Number',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: SvgPicture.asset('assets/icons/back_arrow.svg'),
              ),
            ),
            YMargin(context.height * 300 / AppConstants.designHeight),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 20 / AppConstants.designWidth,),
              child: CustomButton(buttonText: 'Save', onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
