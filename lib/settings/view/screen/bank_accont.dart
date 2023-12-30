import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class BankAccountScreen extends StatelessWidget {
  const BankAccountScreen({super.key});

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
          'Payment Methods',
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
          horizontal: context.width * 15 / AppConstants.designWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(20),
            const Text(
              'Current Method',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColor.blackGrey,
              ),
            ),
            const YMargin(10),
            Container(
              height: context.height * 0.08,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.blackGrey, width: 1.5),),
              child: Row(children: [
                const XMargin(10),
                SvgPicture.asset('assets/icons/cash.svg'),
                const XMargin(10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YMargin(10),
                    Text(
                      'Cash Payment',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColor.black100,
                      ),
                    ),
                    Text(
                      'Default Method',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.black100,
                      ),
                    ),
                  ],
                ),
              ],),
            ),
            const YMargin(30),
            const Text(
              'Choose and Add Your Preferred Payment Method',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColor.blackGrey,
              ),
            ),
            const YMargin(10),
            Container(
              height: context.height * 0.08,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.blackGrey, width: 1.5),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const XMargin(10),
                    SvgPicture.asset('assets/icons/cash.svg'),
                    const XMargin(10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YMargin(10),
                        Text('0001283903032'),
                        Text('Access Bank'),
                      ],
                    ),
                  ],),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text('Update'),
                  ),
                ],
              ),
            ),
            const YMargin(10),
            Container(
              height: context.height * 0.08,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.blackGrey, width: 1.5),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const XMargin(10),
                    SvgPicture.asset('assets/icons/cash.svg'),
                    const XMargin(10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YMargin(10),
                        Text('+234712345678'),
                        Text('MTN Mobile Money'),
                      ],
                    ),
                  ],),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text('Update'),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
                buttonText: 'Add payment method',
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.addPaymentPage);
                },),
            const YMargin(30),
          ],
        ),
      ),
    );
  }
}
