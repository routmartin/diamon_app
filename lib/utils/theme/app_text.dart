import 'package:flutter/material.dart';

import '../values/app_color.dart';

TextTheme get appThemeText => const TextTheme().copyWith(
      headlineLarge: const TextStyle().copyWith(
        fontFamily: 'Inter',
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
      ),
      titleLarge: const TextStyle().copyWith(
        color: AppColors.bigTitleColor,
        fontWeight: FontWeight.w600,
        fontSize: 22.sp,
      ),
      titleMedium: const TextStyle().copyWith(
        fontFamily: 'Inter',
        color: AppColors.meduiemTitleColor,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),
      titleSmall: const TextStyle().copyWith(
        fontFamily: 'Inter',
        color: AppColors.labelTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      bodyMedium: const TextStyle().copyWith(
        fontFamily: 'Inter',
        color: AppColors.subTitleTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
      ),
      bodySmall: const TextStyle().copyWith(
        fontFamily: 'Inter',
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w300,
        fontSize: 10.sp,
      ),
      labelLarge: const TextStyle().copyWith(
        fontFamily: 'Inter',
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
      ),
      labelMedium: const TextStyle().copyWith(
        fontFamily: 'Inter',
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
      ),
      labelSmall: const TextStyle().copyWith(
        fontFamily: 'Poppins',
        color: AppColors.lightGray,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      displayMedium: const TextStyle().copyWith(
        fontFamily: 'Poppins',
        color: AppColors.lightGray,
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
      ),
    );
