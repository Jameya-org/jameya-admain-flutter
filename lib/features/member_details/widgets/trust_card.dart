import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../models/member_details_model.dart';

class TrustCard extends StatelessWidget {
  const TrustCard({
    super.key,
    required this.member,
  });

  final MemberDetailsModel member;

  Widget progress(
      String title,
      int percent,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            Text(
              '$percent%',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),

        SizedBox(height: 6.h),

        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: LinearProgressIndicator(
            value: percent / 100,
            minHeight: 6.h,
            backgroundColor: AppColors.grey200,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final trust = member.trustScore;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Text(
                'درجة الثقة',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          SizedBox(height: 18.h),

          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    progress(
                      'الالتزام بالدفع',
                      trust.paymentCommitment,
                    ),

                    SizedBox(height: 18.h),

                    progress(
                      'توثيق الهوية',
                      trust.identityVerification,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 24.w),

              CircularPercentIndicator(
                radius: 50.r,
                lineWidth: 5.w,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: AppColors.primary,
                backgroundColor: AppColors.grey200,
                percent: trust.score / 100,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${trust.score}',
                      style: AppTextStyles.headline.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),

                    Text(
                      '/100',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),

          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),

              SizedBox(width: 6.w),

              Text(
                'محدث',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.accent,
                ),
              ),

              const Spacer(),

              Text(
                'تحدث تلقائياً كل 30 يوماً',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}