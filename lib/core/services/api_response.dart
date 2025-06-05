import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

sealed class ApiResponse<T> {
  const ApiResponse();


  const factory ApiResponse.success(T data) = ApiSuccess<T>;


  const factory ApiResponse.error(String message, {int? statusCode}) =
      ApiError<T>;


  R when<R>({
    required R Function(T data) success,
    required R Function(String message, int? statusCode) error,
  }) {
    if (this is ApiSuccess<T>) {
      return success((this as ApiSuccess<T>).data);
    } else {
      final err = this as ApiError<T>;
      return error(err.message, err.statusCode);
    }
  }

  /// Generic method to execute an API call
  static Future<ApiResponse<T>> executeApiCall<T>(
    Future<Response<dynamic>> Function() apiCall,
    T Function(dynamic json) fromJson, {
    bool? Function(dynamic json)? checkSuccess,
  }) async {
    bool checkSuccessFlag = true;
    try {
      final response = await apiCall();
      final data = response.data;
      final json = data;

      if (response.statusCode! >= 300) {
        return ApiError(
          response.statusMessage ?? 'Unknown error',
          statusCode: response.statusCode,
        );
      }

      if (json == null) {
        return const ApiError('Response body is not a JSON object');
      }
      checkSuccessFlag = checkSuccess?.call(json) ?? false;

      if (checkSuccessFlag) {
        final msg = json['message'] as String? ?? 'Operation failed';
        return ApiError(msg, statusCode: response.statusCode);
      }
      final result = fromJson(json);
      return ApiSuccess<T>(result);
    } on DioException catch (dioErr, stack) {
      debugPrint('DioException: $dioErr');
      debugPrint(stack.toString());
      return ApiError(dioErr.message ?? 'Dio error');
    } catch (e, stack) {
      debugPrint('Exception: $e');
      debugPrint(stack.toString());
      return ApiError(e.toString());
    }
  }
}

class ApiSuccess<T> extends ApiResponse<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiError<T> extends ApiResponse<T> {
  final String message;
  final int? statusCode;
  const ApiError(this.message, {this.statusCode});
}
