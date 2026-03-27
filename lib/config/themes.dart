import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class AppTheme {
  static const String _fontFamily = 'InstrumentSans';

  static final appThemeData = ThemeData(
    scaffoldBackgroundColor: AppColors.bg,
    fontFamily: _fontFamily,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      ),
      iconTheme: IconThemeData(color: AppColors.text),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      elevation: 0,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      selectedLabelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.outline.withOpacity(0.3)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.mainColor,
      backgroundColor: AppColors.white,
      accentColor: AppColors.secondary,
      cardColor: AppColors.white,
      errorColor: AppColors.error,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: AppColors.outline),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.white,
      filled: true,
      border: InputBorder.none,
      isDense: true,
      hintStyle: const TextStyle(
        fontFamily: _fontFamily,
        color: AppColors.grey,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.outline),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.error),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.outline.withOpacity(0.3),
      thickness: 1,
      space: 0,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
