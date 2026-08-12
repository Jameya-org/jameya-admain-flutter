import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../core/routing/routes.dart';
import 'status_badge.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({
    super.key,
    required this.name,
    required this.phone,
    required this.status,
    required this.id,
  });

  final String name;
  final String phone;
  final String status;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Stack(
        children: [
          // =========================
          // صورة + اسم + رقم الهاتف
          // =========================
          Row(
            textDirection: TextDirection.rtl,
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: Colors.purple.shade100,
                backgroundImage: const AssetImage(
                  'assets/images/user.png',
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        phone,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // =========================
          // Status Badge
          // =========================
          Positioned(
            top: 0,
            left: 0,
            child: StatusBadge(
              status: status,
            ),
          ),

          // =========================
          // Arrow - Bottom Left
          // =========================
          Positioned(
            left: 4.w,
            bottom: 0,
            child: InkWell(
              onTap: () {
                context.push(
                  '${AppRoutes.memberDetails}/$id',
                );
              },
              borderRadius: BorderRadius.circular(20.r),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}