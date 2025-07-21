import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:focus_mate/data/models/login_model.dart';
import 'package:focus_mate/data/service/api_service.dart';

class Loginrepo {
  final ApiService _apiService = ApiService();

  Future<LoginResponse?> loginUser(Login model) async {
    log("Attempting signup with data: ${model.toJson()}");

    try {
      final response = await _apiService.post(
        "/login",
        data: model.toJson(),
      );

      log("Login API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Login successful");
      } else {
        log("Unexpected status code: ${response.statusCode}");
      }

      return LoginResponse.fromJson(response.data);
    } on DioException catch (dioError) {
      log("DioError during Login: ${dioError.message}");
      log("Response: ${dioError.response?.data}");
      return null; // More explicit than just return
    } catch (e, stackTrace) {
      log("Unexpected error during Login: $e");
      log("StackTrace: $stackTrace");
      return null;
    }
  }
}
