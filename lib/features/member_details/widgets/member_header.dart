import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../models/member_details_model.dart';

class MemberHeader extends StatelessWidget {
  const MemberHeader({
    super.key,
    required this.member,
  });

  final MemberDetailsModel member;

  String get initials {
    if (member.legalName.isEmpty) return '';

    final names = member.legalName.split(' ');

    if (names.length == 1) {
      return names.first.substring(0, 1);
    }

    return names.first.substring(0, 1) +
        names[1].substring(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => context.pop(),
          icon:IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.primary,
              size: 24.sp,
            ),
          ),
        ),

        SizedBox(width: 12.w),

        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: const Color(0xFFD9F8FA),
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Center(
            child: Text(
              initials,
              style: AppTextStyles.title.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.legalName,
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 4.h),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  member.id,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ),
            ],
          ),
        ),

        Icon(
          Icons.menu,
          color: AppColors.primary,
          size: 28.sp,
        ),
      ],
    );
  }
}