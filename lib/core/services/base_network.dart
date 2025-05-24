import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  NetworkService() {
    _initializeDio();
  }

  final String baseUrl = "https://dental-nub-app.runasp.net/api/";
  late final Dio _dio;
  String? _token;

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      // receiveDataWhenStatusError: true,
      // followRedirects: false,
      // headers: {"Content-Type": "application/json"},
      validateStatus: (status) => true,
    ));

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_token != null) {
            options.headers["Authorization"] = "Bearer $_token";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          if(response.data!= null){
            if (response.data["token"] != null) {
              _token = response.data["token"];
              _dio.options.headers["Authorization"] = "Bearer $_token";
              var prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', _token!);
            }
          }

          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
      if (kDebugMode)
        PrettyDioLogger(
          request: true,
          responseBody: true,
          requestBody: true,
          requestHeader: true,
        ),
    ]);
  }

  void updateToken(String? newToken) {
    _token = newToken;
    _dio.options.headers["Authorization"] =
        newToken != null ? "Bearer $newToken" : null;
  }

  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    try {
      return await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e,s) {
      print(s);
      throw _handleError(e);
    }
  }

  Future<Response> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    return error;
  }
}
