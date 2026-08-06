import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';

/// Step header showing the step title and descriptive subtitle.
class CreateJameyaHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const CreateJameyaHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headline.copyWith(color: AppColors.textPrimary),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textHint,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
