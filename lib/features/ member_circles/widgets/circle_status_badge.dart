import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CircleStatusBadge extends StatelessWidget {
  const CircleStatusBadge({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final bool active = status == 'نشطة';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xffE8FFF3)
            : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: active
            ? null
            : Border.all(
          color: AppColors.textPrimary,
        ),
      ),
      child: Text(
        status,
        style: AppTextStyles.label.copyWith(
          color: active
              ? AppColors.primary
              : AppColors.textPrimary,
        ),
      ),
    );
  }
}