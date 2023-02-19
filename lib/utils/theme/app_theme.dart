import 'app_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../values/app_color.dart';
import '../values/app_constants.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    fontFamily: "Poppins",
    primaryColor: AppColors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      background: AppColors.white,
      primary: AppColors.white,
      primaryContainer: AppColors.scaffoldBackground,
      secondary: AppColors.seconderyColor,
      surface: AppColors.white,
      inverseSurface: AppColors.black,
      onPrimary: AppColors.black,
      onSecondary: AppColors.white,
      onSurface: AppColors.black,
      onInverseSurface: AppColors.white,
    ),
    textTheme: appThemeText,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.white,
    fontFamily: "Poppins",
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      background: AppColors.white,
      primary: AppColors.white,
      primaryContainer: AppColors.scaffoldBackground,
      secondary: AppColors.seconderyColor,
      surface: AppColors.white,
      inverseSurface: AppColors.black,
      onPrimary: AppColors.black,
      onSecondary: AppColors.white,
      onSurface: AppColors.black,
      onInverseSurface: AppColors.white,
    ),
    textTheme: appThemeText,
  );

  static ThemeMode themeMode() {
    final isDarkMode = GetStorage().read(AppConstants.keyThemeMode);
    if (isDarkMode != null) {
      if (isDarkMode) {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    } else {
      return ThemeMode.light;
    }
  }
}
