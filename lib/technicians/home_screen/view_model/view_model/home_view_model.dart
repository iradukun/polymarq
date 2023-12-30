import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/providers/api_response.dart';
import 'package:polymarq/providers/storage.dart';
import 'package:polymarq/technicians/home_screen/repository/home_repository.dart';
import 'package:polymarq/technicians/home_screen/repository/home_repository_impl.dart';
import 'package:polymarq/technicians/home_screen/view_model/home_state/home_state.dart';

final homeNotifier = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) {
    final homeRepository = ref.watch(homeRepositoryProvider);
    return HomeNotifier(homeRepository, ref);
  },
);

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(this.homeRepository, this.ref) : super(HomeInitial());
  final HomeRepository homeRepository;
  final Ref ref;

  Future<void> createTool({
    required String name,
    required String description,
    required String category,
    required String price,
    required bool isNegotiable,
    required List<File> toolImage,
    required List<String> toolColor,
    required String toolStatus,
  }) async {
    try {
      state = CreateToolLoading();
      final response = await homeRepository.createTools(
        name: name,
        description: description,
        category: category,
        price: price,
        isNegotiable: isNegotiable,
        toolImage: toolImage,
        toolColor: toolColor,
        toolStatus: toolStatus,
      );
      if (response.isSuccessful) {
        state = CreateToolSuccess(
          message: response.message ?? 'Tools created successfully',
        );
      } else {
        state = CreateToolFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = CreateToolFailure(message: e.toString());
    }
  }

  Future<void> rentTools({
    required String id,
    required int duration,
    required String price,
  }) async {
    try {
      state = RentToolLoading();
      final response = await homeRepository.rentTools(
        id: id,
        duration: duration,
        price: price,
      );
      if (response.isSuccessful) {
        state = RentToolSuccess(
          message: response.message ?? 'Tool rented successfully',
        );
      } else {
        state = RentToolFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = RentToolFailure(message: e.toString());
    }
  }

  Future<void> editTools({
    required String uuid,
    required String name,
    required String description,
    required String category,
    required String price,
    required bool isNegotiable,
    required bool isRented,
    required bool isAvailable,
    required String toolStatus,
    List<File>? toolImage,
    List<String>? toolColor,
  }) async {
    try {
      state = EditToolLoading();
      final response = await homeRepository.editTools(
        name: name,
        description: description,
        category: category,
        price: price,
        uuid: uuid,
        isNegotiable: isNegotiable,
        isRented: isRented,
        isAvailable: isAvailable,
        toolImage: toolImage,
        toolColor: toolColor,
        toolStatus: toolStatus,
      );
      if (response.isSuccessful) {
        state = EditToolSuccess(
          message: response.message ?? 'Tool edited successfully',
        );
      } else {
        state = EditToolFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = EditToolFailure(message: e.toString());
    }
  }

  Future<void> negotiateTool({
    required String uuid,
    required String price,
  }) async {
    try {
      state = NegotiateToolLoading();
      final response = await homeRepository.negotiateTool(
        uuid: uuid,
        price: price,
      );
      if (response.isSuccessful) {
        state = NegotiateToolSuccess(
          message: response.message ?? 'Tool edited successfully',
        );

        print('set ${MyPref.checkoutLink}');
      } else {
        state = NegotiateToolFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = NegotiateToolFailure(message: e.toString());
    }
  }

  Future<void> initiaiteToolPurchase({
    required String uuid,
    required int quantity,
  }) async {
    try {
      state = InitiatePurchaseLoading();
      final response = await homeRepository.initiaiteToolPurchase(
        uuid: uuid,
        quantity: quantity,
      );
      if (response.isSuccessful) {
        state = InitiatePurchaseSuccess(
          message: response.message ?? 'Tool edited successfully',
        );
        MyPref.checkoutLink = response.data['authorizationUrl'].toString();
        print('set ${MyPref.checkoutLink}');
      } else {
        state = InitiatePurchaseFailure(
          message: response.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      state = InitiatePurchaseFailure(message: e.toString());
    }
  }

  Future<ApiResponse> deleteTools({required String uuid}) {
    return homeRepository.deleteTools(uuid: uuid);
  }

  Future<ApiResponse> getAcceptedJobs() {
    return homeRepository.getAcceptedJobs();
  }

  Future<ApiResponse> getJobRequest() {
    return homeRepository.getJobRequest();
  }

  Future<ApiResponse> acceptJob({required String uuid, String? price}) {
    return homeRepository.acceptJob(uuid: uuid, price: price);
  }

  Future<ApiResponse> toolPurchaseResponse(
      {required String uuid, required String status,}) {
    return homeRepository.negotiateToolResponse(uuid: uuid, status: status);
  }

  Future<ApiResponse> acceptJobWithoutPrice({
    required String uuid,
  }) {
    return homeRepository.acceptJobWithoutPrice(
      uuid: uuid,
    );
  }

  Future<ApiResponse> declineJob(String uuid) {
    return homeRepository.declineJob(uuid);
  }
}
