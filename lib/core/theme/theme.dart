import 'package:flutter/material.dart';
import 'package:focus_mate/core/constants/app_colors.dart';

class AppTheame {
  static _border([Color color = AppColors.kPrimaryColor]) =>
      OutlineInputBorder(borderRadius: BorderRadius.circular(20));
  static final appTheame = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      border: _border(),
      enabledBorder: _border(),
    ),
    brightness: Brightness.light,
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: AppColors.kPrimaryColor,
    cardColor: const Color(0xFFF9FAFB),
    colorScheme: ColorScheme.light(
      primary: AppColors.kPrimaryColor,
      primaryContainer: AppColors.kPrimaryVariant,
      secondary: AppColors.kSecondaryColor,
      secondaryContainer: AppColors.kSecondaryVariant,
      surface: const Color(0xFFF9FAFB),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );

  final darkTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      border: _border(),
      enabledBorder: _border(),
    ),
    brightness: Brightness.dark,
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: const Color(0xFF1F2937),
    cardColor: const Color(0xFF374151),
    colorScheme: ColorScheme.dark(
      primary: AppColors.kPrimaryColor,
      primaryContainer: AppColors.kPrimaryVariant,
      secondary: AppColors.kSecondaryColor,
      secondaryContainer: AppColors.kSecondaryVariant,
      surface: const Color(0xFF374151),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white70,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F2937),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
