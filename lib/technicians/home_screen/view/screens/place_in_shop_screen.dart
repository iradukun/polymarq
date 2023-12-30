// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/technicians/home_screen/model/tool_category.dart';
import 'package:polymarq/technicians/home_screen/view_model/home_state/home_state.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/home_view_model.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/custom_textfield.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class PlaceInShopScreen extends ConsumerStatefulWidget {
  const PlaceInShopScreen({super.key});

  @override
  ConsumerState<PlaceInShopScreen> createState() => _PlaceInShopScreenState();
}

class _PlaceInShopScreenState extends ConsumerState<PlaceInShopScreen> {
  String selectedStatus = 'new';
  List<String> status = [
    'new',
    'used: like-new',
    'used: very good',
    'used: good',
    'used: worn',
  ];

  List<String> color = [
    '#FF3E3E',
    '#FFE03E',
    '#65FF3E',
    '#34E7FF',
    '#3E46FF',
    '#F03EFF',
    '#FFFFFF',
    '#000000',
  ];

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isSelect = true;
  List<File> imageFileList = [];
  Future<void> selectImages() async {
    final imagePicker = ImagePicker();

    await imagePicker.pickMultiImage().then((value) {
      if (value.isNotEmpty) {
        imageFileList.addAll(value.map((e) => File(e.path)));
      }
    });
    setState(() {});
  }

  List<String> colors = [];

  @override
  Widget build(BuildContext context) {
    final getCategory = ref.watch(getCategoryProvider(''));
    ref.listen(homeNotifier, (prev, next) {
      if (next is CreateToolFailure) {
        CustomAlert.show(context, message: 'error occured');
      }
      if (next is CreateToolSuccess) {
        CustomAlert.show(
          context,
          message: 'Tool created Successfully',
          success: true,
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, AppRoute.technicianDashboard);
        });
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Text(
                  'Place in Shop',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    YMargin(context.height * 10 / AppConstants.designHeight),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            context.width * 15 / AppConstants.designWidth,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tool Name',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          YMargin(
                            context.height * 10 / AppConstants.designHeight,
                          ),
                          CustomTextFieild(
                            suffixImage: Image.asset('assets/images/voice.png'),
                            textName: 'Tool Name...',
                            controller: nameController,
                          ),
                          YMargin(
                            context.height * 10 / AppConstants.designHeight,
                          ),
                          const Text(
                            'Select Category',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          YMargin(
                            context.height * 10 / AppConstants.designHeight,
                          ),
                          getCategory.when(
                            data: (category) {
                              return Autocomplete<ToolCategory>(
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
                                      hintText: 'Select a category',
                                      hintStyle: TextStyle(
                                        color: AppColor.whiteGrey,
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
                                  return category.where((cat) {
                                    return cat.name!
                                        .toLowerCase()
                                        .contains(value.text.toLowerCase());
                                  });
                                },
                                displayStringForOption: (option) =>
                                    option.name!,
                                onSelected: (options) {
                                  categoryController.text = options.name!;
                                  log('');
                                },
                                optionsViewBuilder:
                                    (context, onSelected, options) {
                                  return Align(
                                    alignment: Alignment.topCenter,
                                    child: Material(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.lightGrey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: 250,
                                        width: 350,
                                        child: ListView.builder(
                                          itemCount: options.length,
                                          itemBuilder: (context, index) {
                                            final banks =
                                                options.elementAt(index);
                                            return GestureDetector(
                                              onTap: () {
                                                onSelected(banks);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
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
                          YMargin(
                            context.height * 20 / AppConstants.designHeight,
                          ),
                          const Text(
                            'Tools Status',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          YMargin(
                            context.height * 10 / AppConstants.designHeight,
                          ),
                          DropdownButtonFormField<String>(
                            dropdownColor: Theme.of(context).cardColor,
                            alignment: Alignment.centerLeft,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: context.height * 15 / 891,
                                horizontal: context.width * 10 / 413,
                              ),
                              hintText: 'Select the status of your tool',
                              hintStyle: TextStyle(
                                color: AppColor.whiteGrey,
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
                            //  dropdownColor: Colors.blueAccent,
                            value: selectedStatus,
                            items: status.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedStatus = newValue!;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Toos color available*',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          YMargin(
                            context.height * 20 / AppConstants.designHeight,
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: color
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          colors.add(e);
                                        });
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: fromHex(e),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            ' Some Details about the tool*',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          YMargin(
                            context.height * 10 / AppConstants.designHeight,
                          ),
                          CustomTextFieild(
                            suffixImage: Padding(
                              padding: EdgeInsets.only(
                                bottom: context.height *
                                    40 /
                                    AppConstants.designHeight,
                              ),
                              child: Image.asset('assets/images/voice.png'),
                            ),
                            textName: 'Description...',
                            height: context.height *
                                100 /
                                AppConstants.designHeight,
                            controller: descriptionController,
                            maxLines: 5,
                          ),
                          YMargin(
                            context.height * 20 / AppConstants.designHeight,
                          ),
                          const Text(
                            'Price *',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          YMargin(
                            context.height * 10 / AppConstants.designHeight,
                          ),
                          CustomTextFieild(
                            suffixImage: Image.asset('assets/images/voice.png'),
                            textName: 'Type the Price Here',
                            controller: priceController,
                          ),
                          YMargin(
                            context.height * 20 / AppConstants.designHeight,
                          ),
                          const Text(
                            'This Price is it Negotiable? *',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          YMargin(
                            context.height * 20 / AppConstants.designHeight,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelect = !isSelect;
                                  });
                                },
                                child: Column(
                                  children: [
                                    const Text('YES'),
                                    YMargin(
                                      context.height *
                                          10 /
                                          AppConstants.designHeight,
                                    ),
                                    Container(
                                      width: context.height *
                                          30 /
                                          AppConstants.designHeight,
                                      height: context.height *
                                          30 /
                                          AppConstants.designHeight,
                                      decoration: BoxDecoration(
                                        color: isSelect
                                            ? AppColor.iris
                                            : AppColor.lightBlue,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColor.lightGrey,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: isSelect
                                              ? AppColor.white
                                              : AppColor.blackGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              XMargin(
                                context.width * 30 / AppConstants.designWidth,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelect = !isSelect;
                                  });
                                },
                                child: Column(
                                  children: [
                                    const Text('NO'),
                                    YMargin(
                                      context.height *
                                          10 /
                                          AppConstants.designHeight,
                                    ),
                                    Container(
                                      width: context.height *
                                          30 /
                                          AppConstants.designHeight,
                                      height: context.height *
                                          30 /
                                          AppConstants.designHeight,
                                      decoration: BoxDecoration(
                                        color: isSelect
                                            ? AppColor.lightBlue
                                            : AppColor.iris,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColor.lightGrey,
                                          width: context.width *
                                              2 /
                                              AppConstants.designWidth,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: isSelect
                                              ? AppColor.blackGrey
                                              : AppColor.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          YMargin(
                            context.height * 20 / AppConstants.designHeight,
                          ),
                          RichText(
                            text: const TextSpan(
                              text: 'Upload Some Images of The Tool (',
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: ' 3 Images Maximum',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.iris,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ') *',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          YMargin(
                            context.height * 10 / AppConstants.designHeight,
                          ),
                          if (imageFileList.isEmpty)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColor.lightGrey,
                                  width: 2,
                                ),
                              ),
                              height: 50,
                              child: InkWell(
                                onTap: selectImages,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Select File',
                                        style: TextStyle(
                                          color: AppColor.whiteGrey,
                                          fontSize: context.height * 13 / 891,
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/download.png',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageFileList.length,
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Image.file(
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 150,
                                      File(imageFileList[index].path),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          YMargin(
                            context.height * 20 / AppConstants.designHeight,
                          ),
                          CustomButton(
                            buttonText: 'Place In Shop',
                            onTap: () async {
                              await ref.read(homeNotifier.notifier).createTool(
                                    name: nameController.text,
                                    description: descriptionController.text,
                                    category: categoryController.text,
                                    price: priceController.text,
                                    isNegotiable: isSelect,
                                    toolImage: imageFileList,
                                    toolStatus: selectedStatus,
                                    toolColor: colors,
                                  );
                              log('''
${nameController.text} 
${descriptionController.text}
${categoryController.text}
 ${priceController.text} $isSelect $imageFileList $colors
''');
                            },
                          ),
                          YMargin(
                            context.height * 50 / AppConstants.designHeight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
