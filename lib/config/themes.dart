import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class AppTheme {
  static final appThemeData = ThemeData(
      scaffoldBackgroundColor: AppColors.bg,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.bg),
      // chipTheme: ,
      useMaterial3: true,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.bg,
        elevation: 2.0,
      ),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.transparent),
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.mainColor,
          backgroundColor: AppColors.white,
          cardColor: AppColors.white,
          errorColor: AppColors.error),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: AppColors.outline),
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.primary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.white,
        filled: true,
        border: InputBorder.none,
        isDense: true,
        // hintStyle: AppTextStyles.hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      )
      // fontFamily: 'Satoshi',
      );
}
