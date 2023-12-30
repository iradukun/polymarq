import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/technicians/home_screen/model/tool_category.dart';
import 'package:polymarq/technicians/home_screen/view/screens/category_product_screen.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class ProductCategoryScreen extends ConsumerStatefulWidget {
  const ProductCategoryScreen({super.key});

  @override
  ConsumerState<ProductCategoryScreen> createState() =>
      _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends ConsumerState<ProductCategoryScreen> {
  final TextEditingController _query = TextEditingController();
  final ScrollController categoryScrollController = ScrollController();

  @override
  void initState() {
    categoryScrollController.addListener(() {
      if (categoryScrollController.position.pixels ==
          categoryScrollController.position.maxScrollExtent) {
        ref.read(toolCategoryPage.notifier).state++;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getCategory = ref.watch(getCurrentUsercategoryProvider(_query.text));
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        title: const Text(
          'Shop Tools',
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
          horizontal: context.width * 20 / AppConstants.designWidth,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.height * 320 / 891,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search Here... ',
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: context.height * 10 / 891,
                        horizontal: context.width * 10 / 413,
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
            const YMargin(20),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.myProductPage);
              },
              child: Container(
                height: context.height * 100 / AppConstants.designHeight,
                width: context.width,
                decoration: BoxDecoration(
                  color: AppColor.lightVirgo,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 10 / AppConstants.designWidth,
                    vertical: context.height * 15 / AppConstants.designHeight,
                  ),
                  child: const Center(
                    child: Text(
                      'See all products',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const YMargin(20),
            getCategory.when(
              data: (category) {
                if (category.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:
                            context.height * 300 / AppConstants.designHeight,
                      ),
                      const Center(
                        child: Text(
                          'No category available yet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    controller: categoryScrollController,
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
                              builder: (context) => CategoryProductScreen(
                                uuid: category[index].uuid ?? '',
                                name: category[index].name ?? '',
                              ),
                            ),
                          );
                        },
                        child: CategoryTile(toolCategory: category[index]),
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
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoute.placeInShopage);
        },
        child: SvgPicture.asset('assets/icons/fab.svg'),
      ),
    );
  }
}

class CategoryTile extends ConsumerStatefulWidget {
  const CategoryTile({
    required this.toolCategory,
    super.key,
  });
  final ToolCategory toolCategory;

  @override
  ConsumerState<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends ConsumerState<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 100 / AppConstants.designHeight,
      width: context.width,
      decoration: BoxDecoration(
        color: AppColor.lightVirgo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 10 / AppConstants.designWidth,
          vertical: context.height * 15 / AppConstants.designHeight,
        ),
        child: Column(
          children: [
            YMargin(
              context.height * 10 / AppConstants.designHeight,
            ),
            Text(
              widget.toolCategory.name ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColor.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            YMargin(
              context.height * 10 / AppConstants.designHeight,
            ),
            Text(
              widget.toolCategory.numberOfTools! <= 1
                  ? '${widget.toolCategory.numberOfTools} product available'
                  : '${widget.toolCategory.numberOfTools} products available',
              style: const TextStyle(
                fontSize: 13,
                color: AppColor.black100,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
