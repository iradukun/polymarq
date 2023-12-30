import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:polymarq/technicians/home_screen/model/tool_category.dart';
import 'package:polymarq/technicians/home_screen/model/tool_model.dart'
    show Tool;
import 'package:polymarq/technicians/home_screen/view/screens/tool_share_details.dart';
import 'package:polymarq/technicians/home_screen/view_model/home_state/shop_state.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/provider.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/shop_tool.dart';
import 'package:polymarq/technicians/home_screen/view_model/view_model/tools_view_model.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/contants.dart';
import 'package:polymarq/utils/extension.dart';
import 'package:polymarq/utils/sizing.dart';

class ToolShareScreen extends StatefulHookConsumerWidget {
  const ToolShareScreen({super.key});

  @override
  ConsumerState<ToolShareScreen> createState() => _ToolShareScreenState();
}

class _ToolShareScreenState extends ConsumerState<ToolShareScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final shopToolCategoryVM = ref.watch(shopToolViewModel);
              if (shopToolCategoryVM is ShopToolCategoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (shopToolCategoryVM is ShopToolCategoryFailure) {
                return Center(
                  child: Text(
                    shopToolCategoryVM.message,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                );
              } else if (shopToolCategoryVM is ShopToolCategorySuccess) {
                return buildBody(context, shopToolCategoryVM.data);
              } else if (shopToolCategoryVM is ShopToolCategoryLoaded) {
                return buildBody(context, shopToolCategoryVM.data);
              } else {
                return const Center(
                  child: Text('No Data'),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildBody(
    BuildContext context,
    List<ToolCategory> shopCagories,
  ) {
    return Column(
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
              'Tools Share',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColor.black,
              ),
            ),
            const SizedBox(),
          ],
        ),
        const YMargin(10),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Search Here... ',
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            fillColor: AppColor.iris100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const YMargin(20),
        if (shopCagories.isNotEmpty)
          SizedBox(
            height: 40,
            child: ListView.builder(
              itemCount: shopCagories.length,
              scrollDirection: Axis.horizontal,
              controller: categoryScrollController,
              itemBuilder: (context, index) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref
                      .read(toolCatergoryItemProvider.notifier)
                      .update((state) => shopCagories[0]);
                });

                return ToolCatergoryItem(
                  category: shopCagories[index],
                );
              },
            ),
          ),
        const ToolGridView(),
      ],
    );
  }
}

class ToolCatergoryItem extends ConsumerWidget {
  const ToolCatergoryItem({
    // required this.selectedPosition,
    required this.category,
    super.key,
  });
  final ToolCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCatergory = ref.watch(toolCatergoryItemProvider);
    return InkWell(
      onTap: () {
        ref
            .read(toolCatergoryItemProvider.notifier)
            .update((state) => category);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 10,
        decoration: BoxDecoration(
          color: selectedCatergory!.uuid == category.uuid
              ? AppColor.iris
              : AppColor.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: selectedCatergory.uuid == category.uuid
                ? AppColor.iris
                : AppColor.lightGrey,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Center(
            child: Text(
              category.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColor.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToolGridView extends HookConsumerWidget {
  const ToolGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toolsAsync = ref.watch(getToolsProvider);
    final scrollController = useScrollController();
    useEffect(
      () {
        scrollController.addListener(() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(toolPageProvider.notifier).update((state) => state + 1);
          }
        });
        return null;
      },
      [],
    );
    return toolsAsync.when(
      data: (tools) {
        if (tools.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.height * 300 / AppConstants.designHeight,
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
            controller: scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: context.height * 0.3,
            ),
            itemCount: tools.length,
            itemBuilder: (context, index) {
              final tool = tools[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ToolShareDetailsScreen(allToolsModel: tool),),);
                },
                child: ShopToolsTile(shopToolsModel: tool),
              );
            },
          ),
        );
      },
      error: (e, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: context.height * 300 / AppConstants.designHeight,
            ),
            Center(
              child: Text(
                e.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
      loading: () {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: context.height * 300 / AppConstants.designHeight,
            ),
            const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
        );
      },
    );
  }
}

class ShopToolsTile extends StatelessWidget {
  const ShopToolsTile({
    required this.shopToolsModel,
    super.key,
  });

  final Tool shopToolsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.height * 120 / AppConstants.designHeight,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightBlue, width: 3),
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                      imageUrl: shopToolsModel.images.isEmpty
                          ? 'https://polymarq-dev-media.s3.amazonaws.com/profile_pictures/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image_wylbQ2o.jpg'
                          : shopToolsModel.images[0].image,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),

                Text(
                  shopToolsModel.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColor.black,
                  ),
                ),
               
                Text(
                  '${shopToolsModel.price}\$',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: AppColor.iris,
                  ),
                ),
                const YMargin(2),
                Container(
                  height: 25,
                  width: 100,
                  decoration: BoxDecoration(
                    color: shopToolsModel.negotiable
                        ? AppColor.lightGreen
                        : AppColor.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      children: [
                        if (shopToolsModel.negotiable)
                          SvgPicture.asset('assets/icons/negotiate.svg')
                        else
                          SvgPicture.asset('assets/icons/non_negotiate.svg'),
                        const XMargin(4),
                        Expanded(
                          child: Text(
                            shopToolsModel.negotiable
                                ? 'Negotiable'
                                : 'No Negotiable',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 9,
                              color: AppColor.iris,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
