import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:focus_mate/data/service/dio_clinent.dart';

class ApiService {
  final Dio _dio = DioClient().dio;
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      // Handle Dio-specific errors (network issues, bad responses, timeouts)
      print('GET Error for $path: ${e.response?.statusCode} - ${e.message}');
      rethrow; // Rethrow to be handled by the caller (e.g., repository or BLoC)
    } catch (e) {
      // Handle any other unexpected errors
      print('Unexpected error during GET $path: $e');
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data, 
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      // Handle Dio-specific errors
      log('POST Error for $path: ${e.response?.statusCode} - ${e.message}');
      rethrow;
    } catch (e) {
      // Handle any other unexpected errors
      log('Unexpected error during POST $path: $e');
      rethrow;
}
}


}
