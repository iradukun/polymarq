import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polymarq/routes/app_route.dart';
import 'package:polymarq/technicians/home_screen/model/all_tools_model.dart';
import 'package:polymarq/technicians/home_screen/view/screens/tools_details_screen.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class ShoppTools2Screen extends ConsumerWidget {
  const ShoppTools2Screen({
    required this.uuid,
    required this.name,
    super.key,
  });
  final String uuid;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTool = ref.watch(getToolProvider(uuid));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          name,
          style: const TextStyle(
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
              getTool.when(
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
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 200,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: getTools.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ToolsDetailsScreen(
                                  allToolsModel: getTools[index],
                                ),
                              ),
                            );
                          },
                          child: ShopToolsTile(allToolsModel: getTools[index]),
                        );
                      },
                    ),
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
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

class ShopToolsTile extends StatelessWidget {
  const ShopToolsTile({
    required this.allToolsModel,
    super.key,
  });
  final AllToolsModel allToolsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 150 / 891,
      width: context.width * 120 / 413,
      margin: EdgeInsets.symmetric(horizontal: context.width * 5 / 413),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.lightBlue,
          width: context.width * 3 / 413,
        ),
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 10 / 413,
          vertical: context.height * 15 / 891,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: context.height * 100 / AppConstants.designHeight,
              width: context.width * 90 / AppConstants.designWidth,
              decoration: const BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  imageUrl: allToolsModel.images!.isEmpty
                      ? 'https://polymarq-dev-media.s3.amazonaws.com/profile_pictures/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image_wylbQ2o.jpg'
                      : allToolsModel.images![0].image ?? '',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const YMargin(10),
            Text(
              allToolsModel.name ?? '',
              softWrap: false,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColor.black,
                  overflow: TextOverflow.ellipsis,),
            ),
            YMargin(context.height * 2 / 891),
            Text(
              '${allToolsModel.price ?? 0}\$',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: AppColor.iris,
              ),
            ),
            YMargin(context.height * 2 / 891),
            Container(
              height: context.height * 25 / 891,
              width: context.width * 100 / 413,
              decoration: BoxDecoration(
                color: allToolsModel.negotiable == true
                    ? AppColor.lightGreen
                    : AppColor.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                  children: [
                    if (allToolsModel.negotiable == true)
                      SvgPicture.asset('assets/icons/negotiate.svg')
                    else
                      SvgPicture.asset('assets/icons/non_negotiate.svg'),
                    XMargin(context.width * 4 / 413),
                    Text(
                      allToolsModel.negotiable == true
                          ? 'Negotiable'
                          : 'No negotaiable',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 8,
                        color: AppColor.iris,
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
