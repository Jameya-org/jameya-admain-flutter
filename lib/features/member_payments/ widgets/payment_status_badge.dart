import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class PaymentStatusBadge extends StatelessWidget {
  const PaymentStatusBadge({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final bool paid =
        status == 'مدفوع';

    final bool overdue =
        status == 'متأخر';

    final Color backgroundColor = paid
        ? const Color(0xffD9F8FA)
        : overdue
        ? const Color(0xffFFF2DD)
        : const Color(0xffF3F3F3);

    final Color textColor = paid
        ? AppColors.primary
        : overdue
        ? const Color(0xffE19A00)
        : AppColors.textHint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 7.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
        BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: AppTextStyles.label.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}