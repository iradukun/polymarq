import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/technicians/home_screen/view/widgets/product_tile.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class CategoryProductScreen extends ConsumerStatefulWidget {
  const CategoryProductScreen({
    required this.name,
    required this.uuid,
    super.key,
  });
  final String uuid;
  final String name;

  @override
  ConsumerState<CategoryProductScreen> createState() =>
      _CategoryProductScreenState();
}

class _CategoryProductScreenState extends ConsumerState<CategoryProductScreen> {
  final ScrollController categoryScrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(getMyToolProvider(widget.uuid));
    });
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
    final getMyTool = ref.watch(getMyToolProvider(widget.uuid));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColor.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 15 / AppConstants.designWidth,
        ),
        child: Column(
          children: [
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
            YMargin(
              context.height * 20 / AppConstants.designHeight,
            ),
            getMyTool.when(
              data: (getMyTools) {
                if (getMyTools.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:
                            context.height * 300 / AppConstants.designHeight,
                      ),
                      const Center(
                        child: Text(
                          'No tools available',
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
                  child: ListView.builder(
                    itemCount: getMyTools.length,
                    itemBuilder: (context, index) {
                      return ProductTile(model: getMyTools[index]);
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
