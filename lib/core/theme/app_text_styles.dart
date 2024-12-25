import 'app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

abstract class AppTextStyles {
  static final h1 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 44.sp,
  );

  static final h2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 28.sp,
  );

  static final h3 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
  );

  static final body = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  );

  static final bodyHeavy = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 13.sp,
  );

  static final bodySmall = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  );

  static final bodySmallHeavy = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
  );

  static final link = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    color: AppColors.accentBlack,
  );

  static final appBar = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: AppColors.main,
  );

  static final caption = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: AppColors.accentBlack,
  );

  static final custom0 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    color: Colors.black,
  );

  static final custom1 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    color: Colors.black,
  );

  static final custom2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: Colors.black,
  );

  static final custom3 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: Colors.black,
  );

  static final custom4 = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: const Color(0xFF292D32).withOpacity(0.65),
  );

  static final custom5 = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 11.sp,
    color: AppColors.accentBlack,
  );

  static final custom6 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: Colors.black,
  );
}
