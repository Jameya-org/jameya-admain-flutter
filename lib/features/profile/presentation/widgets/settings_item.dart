import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 22.sp,
            ),
          ),

          SizedBox(width: 12.w),

          Text(
            title,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary,
            ),
          ),

          const Spacer(),

          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primary,
            size: 18.sp,
          ),
        ],
      ),
    );
  }
}