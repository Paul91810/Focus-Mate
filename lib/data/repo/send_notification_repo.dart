import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:focus_mate/data/models/sent_notifications_model.dart';
import 'package:focus_mate/data/service/api_service.dart';

class SendNotificationRepo {
  final ApiService _apiService = ApiService();
  Future<void> sentNotifications(SentNotificationsModel notifications) async {
    final connectivity = await Connectivity().checkConnectivity();
    final isOnline = connectivity != ConnectivityResult.none;
    try {
      if (isOnline) {
        final response = await _apiService.post('/notifications',
            data: notifications.toJson());
        log(response.statusCode.toString());
        if (response.statusCode == 200 || response.statusCode == 201) {
          log("Status Code: ${response.statusCode}");
          log("Response Data: ${response.data.toString()}");
        }
      } else {
        log("📴 No internet. Cant sent Notifications");
      }
    } on DioException catch (dioError) {
      log("❌ DioError: ${dioError.message}");
      log("Response: ${dioError.response?.data.toString()}");
    } catch (e) {
      log("❌ Unexpected error: $e");
    }
  }
}
