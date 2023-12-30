import 'dart:io';

import 'package:polymarq/providers/api_response.dart';

abstract class HomeRepository {
  Future<ApiResponse> createTools({
    required String name,
    required String description,
    required String category,
    required String price,
    required bool isNegotiable,
    required List<File> toolImage,
    required List<String> toolColor,
    required String toolStatus,
  });
  Future<ApiResponse> getToolsCategory({
    required int page,
    String? query,
  });
  Future<ApiResponse> getCurrentUserToolsCategory({
    required int page,
    String? query,
  });
  Future<ApiResponse> getAllTools({
    required int page,
    String? query,
  });
  Future<ApiResponse> getTools({
    required int page,
    required String uuid,
    String? query,
  });
  Future<ApiResponse> getOtherTools({
    required int page,
    required String uuid,
    String? query,
  });
  Future<ApiResponse> getMyTools({
    required int page,
    required String uuid,
    String? query,
  });
  Future<ApiResponse> getNotification({required int page});
    Future<ApiResponse> editNotification({required String uuid,
     required bool isRead,});
      Future<ApiResponse> deleteNotification({required String uuid});
  Future<ApiResponse> getAcceptedJobs();
  Future<ApiResponse> acceptJob({required String uuid, String? price});
  Future<ApiResponse> acceptJobWithoutPrice({
    required String uuid,
  });
  Future<ApiResponse> getJobRequest();
  Future<ApiResponse> declineJob(String uuid);
  Future<ApiResponse> getShopToolsCategories({
    required int page,
    String? query,
  });
  Future<ApiResponse> rentTools({
    required String id,
    required int duration,
    required String price,
  });
  Future<ApiResponse> editTools({
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
  });
  Future<ApiResponse> deleteTools({
    required String uuid,
  });
   Future<ApiResponse> negotiateTool({
    required String uuid,
    required String price,
  });
  
  Future<ApiResponse> negotiateToolResponse({
    required String uuid,
    required String status,
  });
  Future<ApiResponse> otherToolCount();
  Future<ApiResponse> getBanks();
   Future<ApiResponse> myToolCount();
  Future<ApiResponse> initiaiteToolPurchase(
      {required String uuid, required int quantity,});
}
