import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:focus_mate/data/local/user_id.dart';
import 'package:focus_mate/data/models/motivation_model.dart';
import 'package:focus_mate/data/service/api_service.dart';

class GetMotivationRepo {
  final ApiService _dio = ApiService();

  Future<Motivation> getMotivationCombo() async {
    final int userId = await UserId.getUserId();

    try {
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      if (isOnline) {
        final response = await _dio.get("/motivation-content/$userId");
        log("Status Code: ${response.statusCode}");
        log("Response Data: ${response.data.toString()}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          final motivation = Motivation.fromJson(response.data);

          return motivation;
        } else {
          log("⚠️ Unexpected status code: ${response.statusCode}");
          throw Exception('Unexpected status code');
        }
      } else {
        log("📴 No internet. Trying to load from Hive...");
        throw Exception("No internet and no cached motivation found.");
      }
    } on DioException catch (dioError) {
      log("❌ DioError during fetch motivation: ${dioError.message}");
      log("Response: ${dioError.response?.data.toString()}");

      rethrow;
    } catch (e) {
      log("❌ Unexpected error: $e");

      rethrow;
    }
  }
}
