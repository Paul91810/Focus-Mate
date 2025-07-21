import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:focus_mate/data/models/signup_model.dart';
import 'package:focus_mate/data/service/api_service.dart';

class SignupRepo {
  final ApiService _apiService = ApiService();

  Future<SignupResponse?> signupUser(Signup model) async {
    log("Attempting signup with data: ${model.toJson()}");

    try {
      final response = await _apiService.post(
        "/signup",
        data: model.toJson(),
      );

      log("Signup API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Signup successful");
      } else {
        log("Unexpected status code: ${response.statusCode}");
      }

      return SignupResponse.fromJson(response.data);
    } on DioException catch (dioError) {
      log("DioError during signup: ${dioError.message}");
      log("Response: ${dioError.response?.data}");
      return null; // More explicit than just return
    } catch (e, stackTrace) {
      log("Unexpected error during signup: $e");
      log("StackTrace: $stackTrace");
      return null;
    }
  }
}
