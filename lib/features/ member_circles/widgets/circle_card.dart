import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'circle_status_badge.dart';

class CircleCard extends StatelessWidget {
  const CircleCard({
    super.key,
    required this.title,
    required this.amount,
    required this.role,
    required this.status,
  });

  final String title;
  final String amount;
  final String role;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Stack(
        children: [
          /// حالة الدائرة (أعلى الشمال)
          Positioned(
            left: 20.w,
            top: 20.h,
            child: CircleStatusBadge(
              status: status,

            ),
          ),

          /// السهم (أسفل الشمال)
          Positioned(
            left: 20.w,
            bottom: 18.h,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 18.sp,
              color: AppColors.primary,
            ),
          ),

          /// العنوان والمبلغ (يمين)
          Positioned(
            right: 18.w,
            top: 16.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 0.03.h),

                Text(
                  amount,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),

          /// الدور (أسفل اليمين)
          Positioned(
            right: 18.w,
            bottom: 14.h,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFD9F8FA),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                role,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}