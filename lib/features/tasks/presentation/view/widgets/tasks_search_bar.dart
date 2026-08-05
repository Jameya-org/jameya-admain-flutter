import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya/core/utils/app_colors.dart';

/// Reusable search bar matching Screenshots 2 & 3 (RTL search icon on the right)
class TasksSearchBar extends StatelessWidget {
  const TasksSearchBar({
    super.key,
    required this.onChanged,
    this.hintText = 'بحث بالأسم او رقم الهاتف',
  });

  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        ),
        child: TextField(
          onChanged: onChanged,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              fontSize: 13.sp,
              color: AppColors.textHint,
            ),
            hintTextDirection: TextDirection.rtl,
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.r),
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  AppColors.textHint,
                  BlendMode.srcIn,
                ),
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 13.h,
            ),
          ),
        ),
      ),
    );
  }
}
