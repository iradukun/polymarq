import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:polymarq/providers/api.dart';
import 'package:polymarq/providers/api_response.dart';
import 'package:polymarq/providers/constants.dart';

import 'package:polymarq/technicians/home_screen/repository/home_repository.dart';
import 'package:polymarq/utils/extension.dart';

final homeRepositoryProvider =
    Provider((ref) => HomeRepositoryImpl(ref.watch(apiProvider)));

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.api);

  final Api api;
  @override
  Future<ApiResponse> createTools({
    required String name,
    required String description,
    required String category,
    required String price,
    required bool isNegotiable,
    required List<File> toolImage,
    required List<String> toolColor,
    required String toolStatus,
  }) async {
    final files = <MultipartFile>[];

    for (final file in toolImage) {
      files.add(
        await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType(
            'images',
            file.path.split('/').last.split('.').last,
          ),
        ),
      );
    }
    log.d('file $files');
    final formData = FormData.fromMap({
      'category': category,
      'name': name,
      'description': description,
      'price': price,
      'negotiable': isNegotiable,
      'images': files,
      'color_codes': toolColor,
      'condition': toolStatus,
    });

    final response = api.postData(
      ApiConstant.CREATE_TOOLS,
      body: formData,
      contentType: 'multipart/form-data',
      hasHeader: true,
    );
    return response;
  }

  @override
  Future<ApiResponse> getToolsCategory({
    required int page,
    String? query,
  }) async {
    final response = await api.getData(
      ApiConstant.GET_CATEGORY,
      hasHeader: true,
      queryParameters: {
        'limit': 50,
        'order': 'asc',
        'order_by': 'name',
        'page': page,
        'query': query,
      }.removeNullValues(),
    );

    return response;
  }

  @override
  Future<ApiResponse> getAllTools({required int page, String? query}) async {
    final response = await api.getData(
      ApiConstant.ALL_TOOLS,
      hasHeader: true,
      queryParameters: {
        'limit': 50,
       // 'my_tools': true,
        'order': 'asc',
        'order_by': 'name',
        'page': page,
        'query': query,
      }.removeNullValues(),
    );

    return response;
  }

  @override
  Future<ApiResponse> getTools({
    required String uuid,
    required int page,
    String? query,
  }) async {
    final response = await api.getData(
      ApiConstant.ALL_TOOLS,
      hasHeader: true,
      queryParameters: {
        'category': uuid,
        'limit': 50,
        'order': 'asc',
        'order_by': 'name',
        'page': page,
        'query': query,
      }.removeNullValues(),
    );

    return response;
  }

  @override
  Future<ApiResponse> acceptJob({required String uuid, String? price}) {
    final url = '${ApiConstant.ACCEPT_DECLINE_JOB}$uuid/';
    final body = {'status': 'ACCEPTED', 'price_quote': price};
    final response = api.patchData(url, hasHeader: true, body: body);
    print(response);
    return response;
  }

  @override
  Future<ApiResponse> acceptJobWithoutPrice({
    required String uuid,
  }) {
    final url = '${ApiConstant.ACCEPT_DECLINE_JOB}$uuid/';
    final body = {
      'status': 'ACCEPTED',
    };
    final response = api.patchData(url, hasHeader: true, body: body);
    print(response);
    return response;
  }

  @override
  Future<ApiResponse> declineJob(String uuid) {
    final url = '${ApiConstant.ACCEPT_DECLINE_JOB}$uuid/';
    final body = {
      'status': 'DECLINED',
    };
    final response = api.patchData(url, hasHeader: true, body: body);
    print(response);
    return response;
  }

  @override
  Future<ApiResponse> getAcceptedJobs() {
    final response =
        api.getData('${ApiConstant.GET_JOBS}?my_jobs=true', hasHeader: true);
    return response;
  }

  @override
  Future<ApiResponse> getShopToolsCategories({
    required int page,
    String? query,
  }) {
    final response = api.getData(
      ApiConstant.GET_CATEGORY,
      hasHeader: true,
      queryParameters: {
        'page': page,
        'limit': 50,
        'order': 'asc',
        'order_by': 'name',
        'query': query,
      }.removeNullValues(),
    );
    return response;
  }

  @override
  Future<ApiResponse> rentTools({
    required String id,
    required int duration,
    required String price,
  }) {
    final response = api.postData(
      ApiConstant.RENT_TOOL,
      body: {'tool': id, 'rental_duration': duration, 'price': price},
      hasHeader: true,
    );
    return response;
  }

  @override
  Future<ApiResponse> deleteTools({required String uuid}) {
    final url = '${ApiConstant.ALL_TOOLS}$uuid/';

    final response = api.deleteData(
      url,
      hasHeader: true,
    );
    return response;
  }

  @override
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
  }) async {
    final files = <MultipartFile>[];
    if (toolImage != null) {
      for (final file in toolImage) {
        files.add(
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
            contentType: MediaType(
              'images',
              file.path.split('/').last.split('.').last,
            ),
          ),
        );
      }
    }

    log.d('file $files');
    final formData = FormData.fromMap(
      {
        'category': category,
        'name': name,
        'description': description,
        'price': price,
        'negotiable': isNegotiable,
        'images': files,
        'color_codes': toolColor,
        'condition': toolStatus,
        'is_rented': isRented,
        'is_available': isAvailable,
      }.removeNullValues(),
    );
    final url = '${ApiConstant.ALL_TOOLS}$uuid/';
    final response = api.patchData(
      url,
      body: formData,
      contentType: 'multipart/form-data',
      hasHeader: true,
    );
    return response;
  }

  @override
  Future<ApiResponse> getMyTools({
    required int page,
    required String uuid,
    String? query,
  }) async {
    final response = await api.getData(
      ApiConstant.ALL_TOOLS,
      hasHeader: true,
      queryParameters: {
        'category': uuid,
        'limit': 50,
        'my_tools': true,
        'order': 'asc',
        'order_by': 'name',
        'page': page,
        'query': query,
      }.removeNullValues(),
    );

    return response;
  }

  @override
  Future<ApiResponse> getJobRequest() {
    final response = api.getData(
      ApiConstant.JOB_REQUEST,
      hasHeader: true,
    );
    return response;
  }

  @override
  Future<ApiResponse> getCurrentUserToolsCategory({
    required int page,
    String? query,
  }) async {
    final response = await api.getData(
      ApiConstant.GET_CATEGORY,
      hasHeader: true,
      queryParameters: {
        'limit': 50,
        'my_tools': true,
        'order': 'asc',
        'order_by': 'name',
        'page': page,
        'query': query,
      }.removeNullValues(),
    );

    return response;
  }

  @override
  Future<ApiResponse> getOtherTools({
    required int page,
    required String uuid,
    String? query,
  }) async {
    final response = await api.getData(
      ApiConstant.ALL_TOOLS,
      hasHeader: true,
      queryParameters: {
        'category': uuid,
        'limit': 50,
        'order': 'asc',
        'order_by': 'name',
        'others_tools': 'true',
        'page': page,
        'query': query,
      }.removeNullValues(),
    );
    return response;
  }

  @override
  Future<ApiResponse> getNotification({required int page}) async {
    final response = await api.getData(
      ApiConstant.GET_NOTIFICATION,
      hasHeader: true,
      queryParameters: {
        'limit': 50,
        'order': 'asc',
        'page': page,
      }.removeNullValues(),
    );
    return response;
  }

  @override
  Future<ApiResponse> initiaiteToolPurchase({
    required String uuid,
    required int quantity,
  }) async {
    final body = {'tool_uuid': uuid, 'quantity': 1};
    final response = await api.postData(
      ApiConstant.TOOL_PURCHASE,
      hasHeader: true,
      body: body,
    );
    return response;
  }

  @override
  Future<ApiResponse> otherToolCount() async {
    final response = await api.getData(
      ApiConstant.TOOLS_COUNT,
      hasHeader: true,
      queryParameters:
          {'my_tools': false, 'others_tools': true}.removeNullValues(),
    );
    return response;
  }

  @override
  Future<ApiResponse> myToolCount() async {
    final response = await api.getData(
      ApiConstant.TOOLS_COUNT,
      hasHeader: true,
      queryParameters:
          {'my_tools': true, 'others_tools': false}.removeNullValues(),
    );
    return response;
  }

  @override
  Future<ApiResponse> getBanks() async {
    final response = await api.getData(ApiConstant.GET_BANKS,
        hasHeader: true,
        queryParameters: {
          'limit': 200,
          'order': 'asc',
          'page': 1,
        }.removeNullValues(),);
    return response;
  }

  @override
  Future<ApiResponse> negotiateTool(
      {required String uuid, required String price,}) async {
    final body = {
      'tool_uuid': uuid,
      'offered_price': price,
    };
    final response = await api.postData(
      ApiConstant.NEGOTIATE_TOOL,
      hasHeader: true,
      body: body,
    );
    return response;
  }

  @override
  Future<ApiResponse> negotiateToolResponse(
      {required String uuid, required String status,}) async {
    final body = {
      'negotiation_uuid': uuid,
      'status': status,
    };
    final response = await api.postData(
      ApiConstant.NEGOTIATE_TOOL_RESPONSE,
      hasHeader: true,
      body: body,
    );
    return response;
  }

  @override
  Future<ApiResponse> deleteNotification({required String uuid}) async {
    final url = '${ApiConstant.GET_NOTIFICATION}$uuid/';
    final response = await api.deleteData(
      url,
      hasHeader: true,
    );
    return response;
  }

  @override
  Future<ApiResponse> editNotification(
      {required String uuid, required bool isRead,}) async {
    final body = {
      'is_read': isRead,
    };
    final url = '${ApiConstant.GET_NOTIFICATION}$uuid/';
    final response = await api.patchData(
      url,
      hasHeader: true,
      body: body,
    );
    return response;
  }
}
