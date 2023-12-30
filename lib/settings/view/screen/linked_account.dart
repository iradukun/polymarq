import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class LinkedAccount extends StatelessWidget {
  const LinkedAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),),
        title:  const  Text(
          'Linked Account',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20 , color: AppColor.black,),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: context.width*30/ AppConstants.designWidth),
        child: Column(
          children: [
       YMargin(context.height * 20 /  AppConstants.designHeight),
            SvgPicture.asset('assets/icons/link_acct.svg'),
           YMargin(context.height * 20 /  AppConstants.designHeight),
            const Text(
              'Linked your Polymarq Account to Another\nAccount to sync',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.blackGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
           YMargin(context.height * 20 /  AppConstants.designHeight),
            Container(
              height: context.height*50/ AppConstants.designHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.iris,
                  borderRadius: BorderRadius.circular(30),),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset('assets/icons/linkedin.svg'),
                    YMargin(context.height * 10 /  AppConstants.designHeight),
                  const Text(
                  'Linkedin',
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,),
                ),
              ],),
            ),
            YMargin(context.height * 20 /  AppConstants.designHeight),
            Container(
              height: context.height*50/ AppConstants.designHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.iris,
                  borderRadius: BorderRadius.circular(30),),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset('assets/icons/googles.svg'),
             YMargin(context.height * 10 /  AppConstants.designHeight),
                const Text(
                  'Google',
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,),
                ),
              ],),
            ),
            YMargin(context.height * 20 /  AppConstants.designHeight),
            Container(
              height: context.height*50/ AppConstants.designHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.iris,
                  borderRadius: BorderRadius.circular(30),),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset('assets/icons/facebooks.svg'),
                   YMargin(context.height * 10 /  AppConstants.designHeight),
                 const Text(
                  'Facebook',
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,),
                ),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}
