// ignore_for_file: strict_raw_type, avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:polymarq/providers/model/error_response_model.dart';
import 'package:polymarq/utils/extension.dart';

Logger log = Logger();

enum ApiStatus {
  success,
  failure,
}

class ApiResponse{
  ApiResponse({
    required this.isSuccessful,
    this.message,
    this.statusCode,
    this.data,
  });

  final bool isSuccessful;
  String? message;
  int? statusCode;
  dynamic data;

  static ApiResponse response(Response response) {
    var logMessage = '';
    logMessage += 'Request: ${response.realUri}\n';
    logMessage += 'Headers: ${response.requestOptions.headers}\n';
    logMessage += 'Code: ${response.statusCode}\n';
    logMessage += 'Method: ${response.requestOptions.method}\n';
    logMessage += 'Data: ${response.requestOptions.data}\n';
    logMessage += 'Response: ${response.data}';
    log.i(logMessage);

    try {
      final data = response.data as Map<String, dynamic>;

      var isSuccessful = false;
      if (data['success'] != null) {
        isSuccessful = data['success'] == true;
      } else if (data['error'] != null) {
        isSuccessful = false;
      } else {
        isSuccessful = (response.statusCode ?? 200) >= 200 &&
            (response.statusCode ?? 200) <= 299;
      }

      var message = '';
      if (data['message'] != null) {
        message = data['message'].toString();
      } else if (data['error'] != null) {
        try {
          final errorResponseModel = ErrorResponseModel.fromJson(data);
          final listOfErrors = errorResponseModel.error;

          if (listOfErrors != null && listOfErrors.isNotEmpty) {
            final buffer = StringBuffer();
            for (final element in listOfErrors) {
              if ((element.details ?? '').trim().isNotEmpty) {
                buffer.write('${element.details.toString().capitalizeFirst}\n');
              } else if ((element.message ?? '').trim().isNotEmpty) {
                buffer.write('${element.message.toString().capitalizeFirst}\n');
              }
            }
            if (buffer.isNotEmpty) {
              message = buffer.toString();
            } else {
              message = response.statusMessage ?? 'An error occurred';
            }
          } else {
            message = response.statusMessage ?? 'An error occurred';
          }
        } catch (_) {
          message = response.statusMessage ?? 'An error occurred';
        }
      } else {
        message = response.statusMessage ?? 'An error occurred';
      }

      return ApiResponse(
        message: message,
        isSuccessful: isSuccessful,
        data: response.data['result'],
        statusCode: response.statusCode,
      );
    } catch (_) {
      return ApiResponse(
        message: response.statusMessage ?? 'An error occurred',
        isSuccessful: (response.statusCode ?? 200) >= 200 &&
            (response.statusCode ?? 200) <= 299,
        data: response.data,
        statusCode: response.statusCode,
      );
    }
  }
}

extension ApiError on DioException {
  ApiResponse toApiError({CancelToken? cancelToken}) {
    if (response != null) {
      return ApiResponse.response(response!);
    }

    var logMessage = '';
    logMessage += '$type\n';
    logMessage += 'Url: ${requestOptions.uri}\n';
    logMessage += 'Method: ${requestOptions.method}\n';
    logMessage += 'Data: ${requestOptions.data}\n';
    logMessage += 'Error: $message';
    log.e(logMessage);

    switch (type) {
      case DioException.connectionTimeout:
        if (cancelToken != null) {
          cancelToken.cancel();
        }
        return ApiResponse(
          isSuccessful: false,
          message: 'Please check your internet connection or try again later',
        );

      case DioException.connectionError:
        return ApiResponse(
          isSuccessful: false,
          message:
              'Unable to connect to server, please check your internet connection or try again later',
        );

      case DioException.receiveTimeout:
        if (cancelToken != null) {
          cancelToken.cancel();
        }
        return ApiResponse(
          isSuccessful: false,
          message: 'Server took too long to respond, please try again later',
        );

      case DioException.sendTimeout:
        if (cancelToken != null) {
          cancelToken.cancel();
        }
        return ApiResponse(
          isSuccessful: false,
          message: 'Please check your internet connection or try again later',
        );

      case DioException.badResponse:
        if (cancelToken != null) {
          cancelToken.cancel();
        }
        return ApiResponse(
          isSuccessful: false,
          message: 'Please help report this error to Polymarq support',
        );

      case DioException.requestCancelled:
        if (cancelToken != null) {
          cancelToken.cancel();
        }
        return ApiResponse(
          isSuccessful: false,
          message: 'Request cancelled',
        );

      default:
        if (cancelToken != null) {
          cancelToken.cancel();
        }
        return ApiResponse(
          isSuccessful: false,
          message: 'An unknown error occurred, please try again later',
        );
    }
  }
}
