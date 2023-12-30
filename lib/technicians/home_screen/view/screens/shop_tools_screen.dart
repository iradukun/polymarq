import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/technicians/home_screen/view/screens/product_category_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/shop_tools2_screen.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/shop_tool.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class ShopToolsScreen extends ConsumerStatefulWidget {
  const ShopToolsScreen({super.key});

  @override
  ConsumerState<ShopToolsScreen> createState() => _ShopToolsScreenState();
}

class _ShopToolsScreenState extends ConsumerState<ShopToolsScreen> {
  final categoryScrollController = ScrollController();

  int selectedPosition = 0;

  @override
  void initState() {
    super.initState();
    categoryScrollController.addListener(() {
      if (categoryScrollController.position.pixels ==
          categoryScrollController.position.maxScrollExtent) {
        ref.read(indexSetterProvder.notifier).state++;
        ref.read(shopToolViewModel.notifier).getShopToolCategory();
      }
    });
  }

  @override
  void dispose() {
    categoryScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final getCategory = ref.watch(getCategoryProvider(''));
   
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'My Shop Categories',
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
          children: [
            const YMargin(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.width * 300 / AppConstants.designWidth,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search Here... ',
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical:
                            context.height * 10 / AppConstants.designHeight,
                        horizontal:
                            context.width * 10 / AppConstants.designWidth,
                      ),
                      fillColor: AppColor.iris100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset('assets/icons/filter.svg'),
              ],
            ),
            YMargin(context.height * 20 / AppConstants.designHeight),
            getCategory.when(
              data: (category) {
                return Expanded(
                  child: GridView.builder(
                    // controller: categoryScrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 110,
                    ),
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShoppTools2Screen(
                                uuid: category[index].uuid ?? '',
                                name: category[index].name ?? '',
                              ),
                            ),
                          );
                        },
                        child: CategoryTile(
                          toolCategory: category[index],
                        ),
                      );
                    },
                  ),
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
          ],
        ),
      ),
    );
  }
}
