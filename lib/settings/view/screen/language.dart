import 'package:flutter/material.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String groupValue = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),),
        title: const  Text(
          'Languages',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 22, color: AppColor.black,),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width*15/ AppConstants.designWidth),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Search Here...',
                  hintStyle:
                      const TextStyle(color: AppColor.whiteGrey, fontSize: 15),
                  filled: true,
                  contentPadding:
                       EdgeInsets.symmetric(vertical: context.height*10/ AppConstants.designHeight, horizontal: context.width * 20 /  AppConstants.designWidth),
                  fillColor: AppColor.iris100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
              ),
            ),
             YMargin(context.height*20/ AppConstants.designHeight),
            Row(
              children: [
             
                Radio(
                  activeColor: AppColor.iris,
                  value: 'English',
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value.toString();
                    });
                  },
                ),
                const Text('English',
                    style: TextStyle(
                        color: AppColor.black100,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                    ),
                ),
              ],
            ),
                 YMargin(context.height * 10 /  AppConstants.designHeight),
            Row(
              children: [
                Radio(
                  activeColor: AppColor.iris,
                  value: 'German',
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value.toString();
                    });
                  },
                ),
                const Text('German',
                    style: TextStyle(
                        color: AppColor.black100,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                    ),
                ),
              ],
            ),
              YMargin(context.height * 10 /  AppConstants.designHeight),
            Row(
              children: [
                Radio(
                  activeColor: AppColor.iris,
                  value: 'Indonesia',
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value.toString();
                    });
                  },
                ),
                const Text('Indonesia',
                    style: TextStyle(
                        color: AppColor.black100,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                    ),
                ),
              ],
            ),
                   YMargin(context.height * 10 /  AppConstants.designHeight),
            Row(
              children: [
                Radio(
                  activeColor: AppColor.iris,
                  value: 'Italian',
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value.toString();
                    });
                  },
                ),
                const Text('Italian',
                    style: TextStyle(
                        color: AppColor.black100,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                    ),
                ),
              ],
            ),
                    YMargin(context.height * 10 /  AppConstants.designHeight),
            Row(
              children: [
                Radio(
                  activeColor: AppColor.iris,
                  value: 'French',
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value.toString();
                    });
                  },
                ),
                const Text('French',
                    style: TextStyle(
                        color: AppColor.black100,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                    ),
                ),
              ],
            ),
                  YMargin(context.height * 10 /  AppConstants.designHeight),
            Row(
              children: [
                Radio(
                  activeColor: Colors.black,
                  value: 'Kinyarwanda',
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value.toString();
                    });
                  },
                ),
                const Text('Kinyarwanda',
                    style: TextStyle(
                        color: AppColor.black100,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                    ),
                ),
              ],
            ),
              YMargin(context.height * 10 /  AppConstants.designHeight),
            Row(
              children: [
                Radio(
                  activeColor: AppColor.iris,
                  value: 'Kinyarwanda',
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value.toString();
                    });
                  },
                ),
                const Text('Kinyarwanda',
                    style: TextStyle(
                        color: AppColor.black100,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                    ),
                ),
              ],
            ),
                   YMargin(context.height * 10 /  AppConstants.designHeight),
            Row(
              children: [
                Radio(
                  activeColor: AppColor.iris,
                  value: 'Hungarian',
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value.toString();
                    });
                  },
                ),
                const Text('Hungarian',
                    style: TextStyle(
                        color: AppColor.black100,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                    ),
                ),
              ],
            ),
               YMargin(context.height * 80 /  AppConstants.designHeight),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: context.width*20/ AppConstants.designWidth),
              child: CustomButton(buttonText: 'Save', onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
