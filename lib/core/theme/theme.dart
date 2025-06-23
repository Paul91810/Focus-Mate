import 'package:flutter/material.dart';
import 'package:focus_mate/core/theme/constants.dart';

class AppTheame {
  static _border([Color color = AppConstants.kPrimaryColor]) =>
      OutlineInputBorder(borderRadius: BorderRadius.circular(20));
  static final appTheame = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      border: _border(),
      enabledBorder: _border(),
    ),
    brightness: Brightness.light,
    primaryColor: AppConstants.kPrimaryColor,
    scaffoldBackgroundColor: AppConstants.kPrimaryColor,
    cardColor: const Color(0xFFF9FAFB),
    colorScheme: ColorScheme.light(
      primary: AppConstants.kPrimaryColor,
      primaryContainer: AppConstants.kPrimaryVariant,
      secondary: AppConstants.kSecondaryColor,
      secondaryContainer: AppConstants.kSecondaryVariant,
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
    primaryColor: AppConstants.kPrimaryColor,
    scaffoldBackgroundColor: const Color(0xFF1F2937),
    cardColor: const Color(0xFF374151),
    colorScheme: ColorScheme.dark(
      primary: AppConstants.kPrimaryColor,
      primaryContainer: AppConstants.kPrimaryVariant,
      secondary: AppConstants.kSecondaryColor,
      secondaryContainer: AppConstants.kSecondaryVariant,
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
