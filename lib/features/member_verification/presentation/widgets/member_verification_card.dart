import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/features/member_verification/data/models/member_verification_model.dart';

class MemberVerificationCard extends StatelessWidget {
  final MemberVerificationModel member;
  final VoidCallback onTap;

  const MemberVerificationCard({
    super.key,
    required this.member,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.09),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // 1. Profile Avatar (Far Right in RTL)
            CircleAvatar(
              radius: 30.r,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  member.avatarUrl != null && member.avatarUrl!.isNotEmpty
                  ? NetworkImage(member.avatarUrl!)
                  : null,
              child: member.avatarUrl == null || member.avatarUrl!.isEmpty
                  ? Icon(Icons.person, color: Colors.grey.shade600, size: 28.sp)
                  : null,
            ),
            SizedBox(width: 16.w),

            // 2. Member Info Column (Middle Right in RTL)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    member.phone,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Status Badge & Action Icon (Far Left in RTL)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9D5B3).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Text(
                    member.status,
                    style: TextStyle(
                      color: const Color(0xFFF59E0B),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 13.h),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.primary,
                  size: 26.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
