import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:focus_mate/data/local/hive_boxs.dart';
import 'package:focus_mate/data/local/hive_keys.dart';
import 'package:focus_mate/data/local/user_id.dart';
import 'package:focus_mate/data/models/profile_model.dart';
import 'package:focus_mate/data/service/api_service.dart';

class GetProfileRepo {
  final ApiService _dio = ApiService();

  Future<GetProfile> getProfileSmartly() async {
    final connectivity = await Connectivity().checkConnectivity();
    final isOnline = connectivity != ConnectivityResult.none;

    try {
      final int userId = await UserId.getUserId();

      if (isOnline) {
        final response = await _dio.get("/get-profile/$userId");

        log("Status Code: ${response.statusCode}");
        log("Response Data: ${response.data.toString()}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          final profile = GetProfile.fromJson(response.data);
          log("✅ Fetch Profile successful");

          // Save to Hive
          await AppHiveBox.profileBox.put(HiveKeys.userProfile, profile);
          return profile;
        } else {
          log("❗Unexpected status code: ${response.statusCode}");
          throw Exception('Unexpected status code');
        }
      } else {
        log("📴 No internet. Trying to load from Hive...");
        final cachedProfile = AppHiveBox.profileBox.get(HiveKeys.userProfile);
        if (cachedProfile != null) return cachedProfile;
        throw Exception("No internet and no cached profile found.");
      }
    } on DioException catch (dioError) {
      log("❌ DioError: ${dioError.message}");
      log("Response: ${dioError.response?.data.toString()}");

      // Try fallback to Hive
      final cachedProfile = AppHiveBox.profileBox.get(HiveKeys.userProfile);
      if (cachedProfile != null) {
        log("📦 Using cached profile from Hive");
        return cachedProfile;
      }

      rethrow;
    } catch (e) {
      log("❌ Unexpected error: $e");

      final cachedProfile = AppHiveBox.profileBox.get(HiveKeys.userProfile);
      if (cachedProfile != null) {
        log("📦 Using cached profile from Hive");
        return cachedProfile;
      }

      rethrow;
    }
  }
}
