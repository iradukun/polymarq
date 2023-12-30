import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/settings/viewmodels/profile_view_model.dart';
import 'package:polymarq/settings/viewmodels/state/profile_state.dart';
import 'package:polymarq/technicians/home_screen/model/bank_model.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class AddPayment extends ConsumerWidget {
  AddPayment({super.key});
  final _bankSlug = TextEditingController();
  final _accountName = TextEditingController();
  final _accountNo = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getBank = ref.watch(getBankProvider);
    ref.listen(settingViewModelProvider, (prev, next) {
      if (next is CreateBankAccountFailure) {
        CustomAlert.show(context, message: next.message);
      }
      if (next is CreateBankAccountSuccess) {
        CustomAlert.show(context, message: next.message, success: true);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, AppRoute.bankAccountPage);
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
          'Add Payment',
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
          horizontal: context.width * 30 / AppConstants.designWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(context.height * 20 / AppConstants.designHeight),
            const Text(
              'Bank',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.whiteGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            getBank.when(
              data: (bank) {
                return Autocomplete<BankModel>(
                  fieldViewBuilder: (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: context.height * 15 / 891,
                          horizontal: context.width * 10 / 413,
                        ),
                        hintText: 'Select a bank',
                        hintStyle: TextStyle(
                          color: AppColor.black,
                          fontSize: context.height * 13 / 891,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColor.lightGrey,
                            width: context.width * 2 / 413,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColor.lightGrey,
                            width: context.width * 2 / 413,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColor.lightGrey,
                            width: context.width * 2 / 413,
                          ),
                        ),
                      ),
                    );
                  },
                  optionsBuilder: (value) {
                    return bank.where((cat) {
                      return cat.name!
                          .toLowerCase()
                          .contains(value.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (option) => option.name!,
                  onSelected: (options) {
                    _bankSlug.text = options.slug!;
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Material(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.lightGrey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 250,
                          width: 350,
                          child: ListView.builder(
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final banks = options.elementAt(index);
                              return GestureDetector(
                                onTap: () {
                                  onSelected(banks);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    banks.name!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () {
                return const CircularProgressIndicator();
              },
              error: (e, stackTrace) {
                return Text(e.toString());
              },
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            const Text(
              'Account holder name',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.whiteGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            CustomTextFieild(
              suffixImage: const SizedBox(),
              textName: 'Alfa Zihal',
              color: AppColor.black,
              controller: _accountName,
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return 'Please enter your city';
              //   }
              //   return null;
              // },
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            const Text(
              'Account number',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.whiteGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            YMargin(context.height * 10 / AppConstants.designHeight),
            CustomTextFieild(
              suffixImage: const SizedBox(),
              textName: '0001283903032',
              color: AppColor.black,
              controller: _accountNo,
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return 'Please enter your city';
              //   }
              //   return null;
              // },
            ),
            const Spacer(),
            CustomButton(
              buttonText: 'Save',
              onTap: () {
                ref.read(settingViewModelProvider.notifier).createBankAccount(
                      bankSlug: _bankSlug.text,
                      accountName: _accountName.text,
                      accountnumber: _accountNo.text,
                    );
              },
            ),
            const YMargin(40),
          ],
        ),
      ),
    );
  }
}
