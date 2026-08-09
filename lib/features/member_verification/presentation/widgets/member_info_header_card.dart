import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/features/member_verification/data/models/member_verification_model.dart';

class MemberInfoHeaderCard extends StatelessWidget {
  final MemberVerificationModel member;

  const MemberInfoHeaderCard({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // 1. Profile Avatar (Far Right in RTL)
          CircleAvatar(
            radius: 26.r,
            backgroundColor: const Color(0xFFCBD5E1),
            backgroundImage: member.avatarUrl != null && member.avatarUrl!.isNotEmpty
                ? NetworkImage(member.avatarUrl!)
                : null,
            child: member.avatarUrl == null || member.avatarUrl!.isEmpty
                ? Icon(Icons.person, color: const Color(0xFF64748B), size: 30.sp)
                : null,
          ),
          SizedBox(width: 14.w),

          // 2. Info Column (Middle Right in RTL)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: AppTextStyles.headline.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  member.email,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 13.sp,
                    color: const Color(0xFF64748B),
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
