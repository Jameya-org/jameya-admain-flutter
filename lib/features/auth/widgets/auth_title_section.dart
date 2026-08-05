import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_text_styles.dart';

class AuthTitleSection extends StatelessWidget {
  const AuthTitleSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: AppTextStyles.title.copyWith(
            color: Colors.white,
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          subtitle,
          style: AppTextStyles.subtitle.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}