import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),),
        title:  const Text(
          'Notifications',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20, color: AppColor.black,),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: context.width*5/ AppConstants.designWidth),
        child: Column(
          children: [
            ListTile(
              leading: const Text(
                'General Notifications',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColor.black,
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
            YMargin(context.height * 20 /  AppConstants.designHeight),
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
            YMargin(context.height * 20 /  AppConstants.designHeight),
            ListTile(
              leading: const Text(
                'Vibrations',
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
          YMargin(context.height * 20 /  AppConstants.designHeight),
            ListTile(
              leading: const Text(
                'Notify Me When There Is A Job\nInvitation For Me',
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
            YMargin(context.height * 20 /  AppConstants.designHeight),
            ListTile(
              leading: const Text(
                'Apps Updates',
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
             YMargin(context.height * 20 /  AppConstants.designHeight),
            ListTile(
              leading: const Text(
                'New Services Available',
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
            YMargin(context.height * 170 /  AppConstants.designHeight),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: context.width*20/ AppConstants.designWidth),
              child: CustomButton(buttonText: 'Save', onTap: (){}),
            ),
          ],
        ),
      ),
    );
  }
}
