import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';

class AppTheame {
  static OutlineInputBorder _border({Color color = Colors.grey}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: color),
      );

  // DARK THEME
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: AppColors.kPrimaryColor,
    canvasColor: AppColors.kPrimaryColor,
    cardColor: const Color(0xFF374151),

    inputDecorationTheme: InputDecorationTheme(
      
      contentPadding: const EdgeInsets.all(20),
      border: _border(color: Colors.grey.shade700),
      enabledBorder: _border(color: Colors.grey.shade700),
      focusedBorder: _border(color: Colors.white),
      errorBorder: _border(color: Colors.red),
      focusedErrorBorder: _border(color: Colors.redAccent),
      labelStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      hintStyle: TextStyle(color: Colors.white70, fontSize: 14.sp),
    ),

    textTheme: ThemeData.dark().textTheme.copyWith(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 14.sp),
      bodySmall: TextStyle(color: Colors.white, fontSize: 12.sp),

      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(color: Colors.white, fontSize: 12.sp),
      labelSmall: TextStyle(color: Colors.white, fontSize: 11.sp),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 57.sp,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(color: Colors.white, fontSize: 45.sp),
      displaySmall: TextStyle(color: Colors.white, fontSize: 36.sp),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.white24,
      selectionHandleColor: Colors.white,
    ),

    iconTheme: const IconThemeData(color: Colors.white),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    colorScheme: ColorScheme.dark(
      primary: AppColors.kPrimaryColor,
      primaryContainer: AppColors.kPrimaryColor,
      secondary: AppColors.kSecondryColor,
      secondaryContainer: AppColors.kPrimaryColor,
      surface: const Color(0xFF374151),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white70,
    ),
  );

  // LIGHT THEME
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    cardColor: const Color(0xFFF9FAFB),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      border: _border(color: Colors.grey.shade400),
      enabledBorder: _border(color: Colors.grey.shade400),
      focusedBorder: _border(color: AppColors.kPrimaryColor),
      errorBorder: _border(color: Colors.red),
      focusedErrorBorder: _border(color: Colors.redAccent),
      labelStyle: const TextStyle(color: Colors.black87),
      hintStyle: const TextStyle(color: Colors.black54),
    ),

    textTheme: ThemeData.light().textTheme.copyWith(
      bodyLarge: const TextStyle(color: Colors.black87),
      bodyMedium: const TextStyle(color: Colors.black87),
      labelLarge: const TextStyle(color: Colors.black87),
      titleLarge: const TextStyle(color: Colors.black87),
      displayLarge: const TextStyle(color: Colors.black87),
      displayMedium: const TextStyle(color: Colors.black87),
      displaySmall: const TextStyle(color: Colors.black87),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.kPrimaryColor,
      selectionColor: AppColors.kPrimaryColor,
      selectionHandleColor: AppColors.kPrimaryColor,
    ),

    iconTheme: const IconThemeData(color: Colors.black87),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    colorScheme: ColorScheme.light(
      primary: AppColors.kPrimaryColor,
      primaryContainer: AppColors.kPrimaryColor,
      secondary: AppColors.kSecondryColor,
      secondaryContainer: AppColors.kSecondryColor,
      surface: const Color(0xFFF9FAFB),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black87,
    ),
  );
}
