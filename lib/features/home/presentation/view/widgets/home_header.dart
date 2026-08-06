import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya/core/utils/app_colors.dart';
import 'package:jameya/core/utils/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        // بدون border ولا border radius بارزة - كونتينر خفيف
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          // الأفاتار على اليمين (RTL)
          CircleAvatar(
            radius: 26.r,
            backgroundImage: const AssetImage('assets/images/profile.png'),
            backgroundColor: AppColors.grey200,
          ),
          SizedBox(width: 14.w),
          // التحية على اليسار من الأفاتار في RTL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'صباح الخير ، هشام',
                  style: AppTextStyles.headline.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'ابدأ يومك بمتابعة أهم المهام.',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 13.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
