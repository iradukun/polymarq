import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/settings/viewmodels/profile_view_model.dart';
import 'package:polymarq/settings/viewmodels/state/profile_state.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class DeleteAccount2Screen extends ConsumerStatefulWidget {
  const DeleteAccount2Screen({super.key});

  @override
  ConsumerState<DeleteAccount2Screen> createState() =>
      _DeleteAccount2ScreenState();
}

class _DeleteAccount2ScreenState extends ConsumerState<DeleteAccount2Screen> {
  bool passwordVisible = false;
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen(settingViewModelProvider, (prev, next) {
      if (next is DeleteAccountFailure) {
        CustomAlert.show(context, message: next.message);
      }
      if (next is DeleteAccountSuccess) {
        CustomAlert.show(context,
            message: 'account deleted successfully', success: true,);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, AppRoute.onboardingPage);
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
        title: const Text(
          'Delete Account',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
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
            Container(
              padding: EdgeInsets.all(
                context.height * 10 / AppConstants.designHeight,
              ),
              height: context.height * 100 / AppConstants.designHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.iris100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/user2.png'),
                  XMargin(context.width * 20 / AppConstants.designWidth),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(context.height * 10 / AppConstants.designHeight),
                      const Text(
                        'Alfa Zihal',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: AppColor.black,
                        ),
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
            YMargin(context.height * 20 / AppConstants.designHeight),
            const Text(
              'Confirm your password',
              style: TextStyle(
                fontSize: 10,
                color: AppColor.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            const Text(
              'Please enter your password to complete your account deactivation.',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.blackGrey,
              ),
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            CustomTextFieild(
              color: AppColor.black,
              textName: '************',
              obscureText: passwordVisible,
              controller: _password,
              suffixImage: InkWell(
                onTap: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
                child: Image.asset(
                  passwordVisible == true
                      ? 'assets/images/visibility_off.png'
                      : 'assets/images/unvisible.png',
                  color: AppColor.black,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                bottom: context.height * 30 / AppConstants.designHeight,
              ),
              child: CustomButton(
                buttonText: 'Delete Account',
                onTap: () {
                  deleteDialog(context, _password.text);
                },
                color: AppColor.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteDialog(BuildContext context, String password) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete account?',
            style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          content: const Text(
            'Are you sure you want to proceed with deleting your polymarq account',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Discard'),
            ),
            TextButton(
              onPressed: () {
                print('pass ${_password.text}');
                print('past $password');
                ref
                    .watch(settingViewModelProvider.notifier)
                    .deleteAccount(password: password);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
