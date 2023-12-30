import 'package:flutter/material.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: context.width*20/AppConstants.designWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             YMargin(context.height*100/AppConstants.designHeight),
            const Text(
              'Start hiring from millions of expert\nTechnicians on Polymarq.',
              style: TextStyle(
                  fontSize: 20,
                  color: AppColor.black,
                  fontWeight: FontWeight.w900,
              ),
            ),
             YMargin(context.height*20/AppConstants.designHeight),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                height: context.height * 60 / AppConstants.designHeight,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: selectedIndex == 0
                            ? AppColor.iris
                            : AppColor.lightGrey,
                        width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:context.width* 10/AppConstants.designWidth),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Looking for Technicians',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500,
                            ),
                        ),
                        Container(
                            width: context.height*30/AppConstants.designHeight,
                            height: context.height *30 / AppConstants.designHeight,
                            decoration: BoxDecoration(
                              color: AppColor.lightBlue,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: selectedIndex == 0
                                      ? AppColor.iris
                                      : AppColor.lightGrey,
                                  width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                // size: 15,
                                color: AppColor.blackGrey,
                              ),
                            ),
                        ),
                      ],
                  ),
                ),
              ),
            ),
             YMargin(context.height*20/AppConstants.designHeight),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                height:  context.height * 60 / AppConstants.designHeight,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: selectedIndex == 1
                            ? AppColor.iris
                            : AppColor.lightGrey,
                        width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: context.width*10/AppConstants.designWidth),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Technicians looking for work',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500,
                            ),
                        ),
                        Container(
                            width: context.height * 30 / AppConstants.designHeight,
                            height: context.height * 30 / AppConstants.designHeight,
                            decoration: BoxDecoration(
                              color: AppColor.lightBlue,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: selectedIndex == 1
                                      ? AppColor.iris
                                      : AppColor.lightGrey,
                                  width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                // size: 15,
                                color: AppColor.blackGrey,
                              ),
                            ),
                        ),
                      ],
                  ),
                ),
              ),
            ),
             YMargin(context.height * 40 / AppConstants.designHeight),
            CustomButton(
              buttonText: 'Submit',
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const TechnicianProfileScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
