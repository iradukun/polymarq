// ignore_for_file: strict_raw_type, inference_failure_on_function_invocation

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polymarq/authentication/view/screens/onboarding_screen.dart';
import 'package:polymarq/providers/api_response.dart';
import 'package:polymarq/providers/constants.dart';
import 'package:polymarq/providers/storage.dart';
import 'package:polymarq/routes/app_route.dart';

//swagger docs
//https://dev.polymarqbackend.com/api/v1/docs/

final apiProvider = Provider((ref) => Api());

class Api {
  Api() {
    _client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log.d('request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log.d('response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          // log.e(
          //   'error: ${e.message}, res: ${e.response?.statusCode}  data: ${e.response?.data}',
          // );
          log.e(e.response?.data);
          final errorRes = e.toApiError(cancelToken: token);

          if (e.response!.statusCode! == 403
              //  &&
              //     errorRes.message == 'Given token not valid for any token type'
              ) {
            await refreshToken();
            return handler.resolve(await _retry(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    );
  }
  static String baseUrl = ApiConstant.BASE_URL;

  CancelToken token = CancelToken();
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 40),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  //final Dio _dio = Dio(_options)..interceptors.add(PrettyDioLogger());
  Future<ApiResponse> postData(
    String url, {
    bool hasHeader = false,
    dynamic body,
    List<File>? files,
    List<String>? fileFields,
    bool cancelFormerRequests = false,
    Dio? customClient,
    String? contentType,
  }) async {
    try {
      final head = {
        'Authorization': 'Bearer ${MyPref.accessToken}',
      };

      if (cancelFormerRequests) {
        token.cancel();
      }

      if ((files ?? []).isEmpty) {
        final request = await (customClient ?? _client).request(
          url,
          data: body,
          options: Options(
            method: 'POST',
            headers: hasHeader ? head : null,
            contentType: contentType ?? 'application/json',
          ),
        );
        return ApiResponse.response(request);
      } else {
        if (files!.length != fileFields!.length) {
          throw Exception('files and fileFields must be of same length');
        }
        final data = body as Map<String, dynamic>;
        for (var i = 0; i < files.length; i++) {
          data[fileFields[i]] = await MultipartFile.fromFile(
            files[i].path,
            filename: files[i].path.split('/').last,
          );
        }
        final request = await (customClient ?? _client).request(
          url,
          data: FormData.fromMap(data),
          cancelToken: token,
          options: Options(
            method: 'POST',
            headers: hasHeader ? head : null,
            contentType: 'application/json',
          ),
        );
        return ApiResponse.response(request);
      }
    } on DioException catch (e) {
      print(e);
      return e.toApiError(cancelToken: token);
    } on SocketException {
      var logMessage = '';
      logMessage += 'SocketException: \n';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Data: $body\n';
      logMessage += 'Method: POST';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } on Exception catch (e) {
      var logMessage = '';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Data: $body\n';
      logMessage += 'Method: POST';
      logMessage += 'Exception: $e \n';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: 'An error occurred, please try again later',
      );
    }
  }

  Future<ApiResponse> deleteData(
    String url, {
    bool hasHeader = false,
    dynamic body,
    bool cancelFormerRequests = false,
    Dio? customClient,
  }) async {
    final head = {
      'Authorization': 'Bearer ${MyPref.accessToken}',
    };
    if (cancelFormerRequests) {
      token.cancel();
    }
    try {
      final request = await (customClient ?? _client).request(
        url,
        data: body,
        cancelToken: token,
        options: Options(
          method: 'DELETE',
          headers: hasHeader ? head : null,
          contentType: 'application/json',
        ),
      );
      return ApiResponse.response(request);
    } on DioException catch (e) {
      return e.toApiError(cancelToken: token);
    } on SocketException {
      var logMessage = '';
      logMessage += 'SocketException: \n';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Data: $body\n';
      logMessage += 'Method: DELETE';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } on Exception catch (e) {
      var logMessage = '';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Data: $body\n';
      logMessage += 'Method: DELETE';
      logMessage += 'Exception: $e \n';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse> putData(
    String url, {
    bool hasHeader = false,
    dynamic body,
    bool cancelFormerRequests = false,
    Dio? customClient,
  }) async {
    final head = {
      'Authorization': 'Bearer ${MyPref.accessToken}',
    };

    if (cancelFormerRequests) {
      token.cancel();
    }
    try {
      final request = await (customClient ?? _client).request(
        url,
        data: body,
        cancelToken: token,
        options: Options(
          method: 'PUT',
          headers: hasHeader ? head : null,
          contentType: 'application/json',
        ),
      );
      return ApiResponse.response(request);
    } on DioException catch (e) {
      return e.toApiError(cancelToken: token);
    } on SocketException {
      var logMessage = '';
      logMessage += 'SocketException: \n';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Data: $body\n';
      logMessage += 'Method: PUT';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } on Exception catch (e) {
      var logMessage = '';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Data: $body\n';
      logMessage += 'Method: PUT';
      logMessage += 'Exception: $e \n';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse> patchData(
    String url, {
    bool hasHeader = false,
    dynamic body,
    bool cancelFormerRequests = false,
    Dio? customClient,
    String? contentType,
  }) async {
    final head = {
      'Authorization': 'Bearer ${MyPref.accessToken}',
    };
    if (cancelFormerRequests) {
      token.cancel();
    }
    try {
      final request = await (customClient ?? _client).request(
        url,
        data: body,
        cancelToken: token,
        options: Options(
          method: 'PATCH',
          headers: hasHeader ? head : null,
          contentType: contentType ?? 'application/json',
        ),
      );
      return ApiResponse.response(request);
    } on DioException catch (e) {
      return e.toApiError(cancelToken: token);
    } on SocketException {
      var logMessage = '';
      logMessage += 'SocketException: \n';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Data: $body\n';
      logMessage += 'Method: PATCH';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } on Exception catch (e) {
      var logMessage = '';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Data: $body\n';
      logMessage += 'Method: PATCH';
      logMessage += 'Exception: $e \n';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse> getData(
    String url, {
    bool hasHeader = false,
    bool cancelFormerRequests = false,
    Dio? customClient,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final head = {
        'Authorization': 'Bearer ${MyPref.accessToken}',
      };
      print('gg ${MyPref.accessToken}');
      if (cancelFormerRequests) {
        token.cancel();
      }
      final request = await (customClient ?? _client).request(
        url,
        cancelToken: token,
        queryParameters: queryParameters,
        options: Options(method: 'GET', headers: hasHeader ? head : null),
      );
      return ApiResponse.response(request);
    } on DioException catch (e) {
      return e.toApiError(cancelToken: token);
    } on SocketException {
      var logMessage = '';
      logMessage += 'SocketException: \n';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Method: GET';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: 'Please check your internet connection or try again later',
      );
    } on Exception catch (e) {
      var logMessage = '';
      logMessage += 'Url: ${baseUrl + url}\n';
      logMessage += 'Method: GET';
      logMessage += 'Exception: $e \n';
      log.e(logMessage);
      return ApiResponse(
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<void> refreshToken() async {
    final res = await postData(
      ApiConstant.REFRESH_TOKEN,
      body: {
        'refresh': MyPref.refreshToken,
      },
    );
    if (res.isSuccessful) {
      final rawData = Map<String, dynamic>.from(res.data as Map);
      final token = rawData['access'] as String;
      MyPref.accessToken = token;
    } else {
      await MyPref.clearBoxes();
      await Navigator.pushAndRemoveUntil(
        AppRoute.navigatorKey.currentContext!,
        MaterialPageRoute<Widget>(
          builder: (_) => OnboardingScreen(
            key: UniqueKey(),
          ),
        ),
        (route) => false,
      );
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOption) {
    final option = Options(
      method: requestOption.method,
      headers: requestOption.headers,
      sendTimeout: const Duration(seconds: 10),
    );
    return _client.request(
      requestOption.path,
      data: requestOption.data,
      queryParameters: requestOption.queryParameters,
      options: option,
    );
  }

  void cancelAllRequest({bool clearCachedData = false}) {
    token.cancel();
    if (clearCachedData) {
      MyPref.clearBoxes();
    }
  }
}
