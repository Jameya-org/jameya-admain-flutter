import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya/core/utils/app_colors.dart';

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
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/search.svg',
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(
              AppColors.grey500,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              textAlignVertical: TextAlignVertical.center,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: AppColors.textPrimary,
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.grey500,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
                isCollapsed: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
