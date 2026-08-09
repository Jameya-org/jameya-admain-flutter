import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';

// Reusable text styles based on a consistent type scale
// All styles use the Inter font via google_fonts
abstract final class AppTextStyles {
  const AppTextStyles._();

  static TextStyle get appTitle => GoogleFonts.inter(
    fontSize: 44.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    height: 1.5,
    letterSpacing: -.02,
  );

  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: -.02,
  );

  static TextStyle get displayMedium => GoogleFonts.inter(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: -.02,
  );

  static TextStyle get headline => GoogleFonts.inter(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: -.02,
  );

  static TextStyle get title => GoogleFonts.inter(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: -.02,
  );

  static TextStyle get appBarTitle => GoogleFonts.inter(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle get subtitle => GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: -.02,
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: -.02,
    color: AppColors.primary,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -.02,
  );

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: -.02,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -.02,
  );
}
