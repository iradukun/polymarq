import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/technicians/home_screen/view/widgets/all_product_tile.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class MyProductScreen extends ConsumerStatefulWidget {
  const MyProductScreen({super.key});

  @override
  ConsumerState<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends ConsumerState<MyProductScreen> {
  final ScrollController categoryScrollController = ScrollController();
  final TextEditingController _query = TextEditingController();
  @override
  void initState() {
    categoryScrollController.addListener(() {
      if (categoryScrollController.position.pixels ==
          categoryScrollController.position.maxScrollExtent) {
        ref.read(allToolsPage.notifier).state++;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allTool = ref.watch(getAllToolProvider(_query.text));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'My Products',
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
            allTool.when(
              data: (getTools) {
                if (getTools.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:
                            context.height * 300 / AppConstants.designHeight,
                      ),
                      const Center(
                        child: Text(
                          'No tool available ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: getTools.length,
                        controller: categoryScrollController,
                        itemBuilder: (context, index) {
                       return   AllProductTile(allToolsModel: getTools[index]);
                        },),
                  );
                }
              },
              loading: () {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
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
