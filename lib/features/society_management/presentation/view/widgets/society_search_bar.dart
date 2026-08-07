import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import '../../viewmodel/society_cubit.dart';

class SocietySearchBar extends StatelessWidget {
  const SocietySearchBar({super.key});

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
              onChanged: (value) => context.read<SocietyCubit>().search(value),
              textAlignVertical: TextAlignVertical.center,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: AppColors.textPrimary,
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: 'البحث عن جمعية...',
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
