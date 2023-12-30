import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/technicians/home_screen/view/screens/shop_tools2_screen.dart';
import 'package:polymarq/technicians/home_screen/view/screens/tools_details_screen.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class AllShopToolScreen extends ConsumerWidget {
  const AllShopToolScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTool = ref.watch(getAllToolProvider(''));
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 10 / 413),
          child: Column(
            children: [
            
              YMargin(context.height * 20 / 891),
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
              YMargin(context.height * 20 / 891),
              allTool.when(
                data: (allTools) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 200,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: allTools.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ToolsDetailsScreen(
                                  allToolsModel: allTools[index],
                                ),
                              ),
                            );
                          },
                          child: ShopToolsTile(allToolsModel: allTools[index]),
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
