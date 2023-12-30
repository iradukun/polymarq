import 'package:flutter/material.dart';
import 'package:polymarq/settings/view/screen/delete_account2.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

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
          'Delete Account',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize:  22,
              color: AppColor.black,),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 15 /  AppConstants.designWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(context.height * 15 /  AppConstants.designHeight),
              height: context.height * 100 /  AppConstants.designHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.iris100,
                  borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/user2.png'),
                  XMargin(context.width * 20 /  AppConstants.designWidth),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(context.height * 10 /  AppConstants.designHeight),
                       const Text(
                        'Alfa Zihal',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize:  22 ,
                            color: AppColor.black,),
                      ),
                      const Text(
                        'View Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColor.blackGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            YMargin(context.height * 20 /  AppConstants.designHeight),
            const Text(
              'This will delete your account',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
              ),
            ),
            YMargin(context.height * 10 /  AppConstants.designHeight),
            const Text(
              'You’re about to start the process of delete your Polymarq account. Your display name, email, and public profile will no longer be viewable on our platforms.',
              style: TextStyle(
                fontSize: 15,
                color: AppColor.blackGrey,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: context.height * 30 /  AppConstants.designHeight),
              child: CustomButton(
                buttonText: 'Continue',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<DeleteAccount2Screen>(builder: (context) => const DeleteAccount2Screen()),
                  );
                },
                color: AppColor.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
