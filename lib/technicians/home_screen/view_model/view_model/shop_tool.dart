import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:polymarq/technicians/home_screen/model/tool_category.dart';
import 'package:polymarq/technicians/home_screen/repository/home_repository_impl.dart';
import 'package:polymarq/technicians/home_screen/view_model/home_state/shop_state.dart';

final shopToolViewModel =
    StateNotifierProvider<ShopToolNotifier, ShopToolState>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return ShopToolNotifier(ref, homeRepository)..getShopToolCategory();
});

final indexSetterProvder = StateProvider<int>((ref) => 0);

class ShopToolNotifier extends StateNotifier<ShopToolState> {
  ShopToolNotifier(this.ref, this.homeRepository) : super(ShopToolInitial());
  Ref ref;
  final HomeRepositoryImpl homeRepository;

  Future<void> getShopToolCategory() async {
    try {
      state = ShopToolCategoryLoading();
      final page = ref.read(indexSetterProvder.notifier).state + 1;
      print('page: $page');
      final response = await homeRepository.getShopToolsCategories(page: page);
      if (response.isSuccessful) {
        log('res ${response.data}');
        final catergories = List<Map<String, dynamic>>.from(
          response.data['data'] as List<dynamic>,
        );
        log(' this is catergories $catergories');
        if (catergories.isEmpty) {
          if (state is ShopToolCategorySuccess) {
            state = ShopToolCategoryLoaded(
              data: (state as ShopToolCategorySuccess).data,
            );
          } else {
            state = const ShopToolCategoryLoaded(data: []);
          }

          return;
        }

        if (state is ShopToolCategorySuccess) {
          final data = (state as ShopToolCategorySuccess).data;
          state = ShopToolCategorySuccess(
            message:
                response.message ?? 'ShopToolCategory requested successfully',
            data: [
              ...data,
              ...catergories.map(
                ToolCategory.fromJson,
              ),
            ],
          );
          log('this is data $data');
          return;
        }
        state = ShopToolCategorySuccess(
          message:
              response.message ?? 'ShopToolCategory requested successfully',
          data: [
            ...catergories.map(
              ToolCategory.fromJson,
            ),
          ],
        );

        // final converted = catergories.map(
        //   ToolCategory.fromJson,
        // );
        // log.d(converted);
        // log.d('first converted ${converted.first.name}}');
      } else {
        state = ShopToolCategoryFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
      // state = const ShopToolCategorySuccess(message: 'Success', data: []);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      state = ShopToolCategoryFailure(message: e.toString());
    }
  }
}
