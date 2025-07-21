import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:focus_mate/data/local/user_id.dart';
import 'package:focus_mate/data/models/get_notifications_model.dart';
import 'package:focus_mate/data/service/api_service.dart';

class GetNotificationsRepo {
  final ApiService _dio = ApiService();

  Future<List<GetNotificationsModel>?> getNotifications() async {
    final int userId = await UserId.getUserId();

    try {
      final connectivity = await Connectivity().checkConnectivity();
      final isOnline = connectivity != ConnectivityResult.none;

      if (isOnline) {
        final response = await _dio.get("/notifications/$userId");
        log("Status Code: ${response.statusCode}");
        log("Response Data: ${response.data.toString()}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          final List<dynamic> list = response.data;
          final notifications = list
              .map((item) =>
                  GetNotificationsModel.fromJson(item as Map<String, dynamic>))
              .toList();

          return notifications;
        } else {
          log("⚠️ Unexpected status code: ${response.statusCode}");
          return null;
        }
      } else {
        log("📴 No internet. Trying to load from Hive...");
        return null;
      }
    } on DioException catch (dioError) {
      log("❌ DioError during fetch motivation: ${dioError.message}");
      log("Response: ${dioError.response?.data.toString()}");

      return null;
    } catch (e) {
      log("❌ Unexpected error: $e");

      return null;
    }
  }
}
