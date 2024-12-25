import 'app_colors.dart';
import 'app_text_styles.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final theme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.main,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: AppColors.main,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.main,
        textStyle: AppTextStyles.bodyHeavy,
        minimumSize: const Size(double.infinity, 50),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextStyles.body,
      enabledBorder: borderStyle,
      focusedBorder: borderStyle,
      errorBorder:
          borderStyle.copyWith(borderSide: const BorderSide(color: Colors.red)),
      focusedErrorBorder:
          borderStyle.copyWith(borderSide: const BorderSide(color: Colors.red)),
      iconColor: AppColors.accentBlack,
    ),
    cardTheme: const CardTheme(
      elevation: 0,
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      titleTextStyle: AppTextStyles.appBar,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.main,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: false,
    ),
  );
}

final borderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(
    width: 0.5,
    color: AppColors.accentBlack,
  ),
);
