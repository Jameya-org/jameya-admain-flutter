import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
  });

  final String status;

  String get normalizedStatus => status.toUpperCase();

  // =========================
  // النص الظاهر
  // =========================
  String get displayStatus {
    switch (normalizedStatus) {
      case 'APPROVED':
      case 'ACTIVE':
        return 'موثق';

      case 'PENDING':
      case 'UNDER_REVIEW':
        return 'قيد الانتظار';

      case 'REJECTED':
        return 'معلق';

      case 'SUSPENDED':
        return 'معلق';

      case 'NOT_STARTED':
        return 'غير موثق';

      default:
        return status;
    }
  }

  // =========================
  // لون الخلفية
  // =========================
  Color get backgroundColor {
    switch (normalizedStatus) {
      case 'APPROVED':
      case 'ACTIVE':
        return const Color(0xFFE9FFF1);

      case 'PENDING':
      case 'UNDER_REVIEW':
        return const Color(0xFFFFF2DD);

      case 'REJECTED':
        return const Color(0xFFDBDBDB);

      case 'SUSPENDED':
        return Colors.white;

      case 'NOT_STARTED':
        return const Color(0xFFF5F5F5);

      default:
        return AppColors.backgroundLight;
    }
  }

  // =========================
  // لون النص
  // =========================
  Color get textColor {
    switch (normalizedStatus) {
      case 'APPROVED':
      case 'ACTIVE':
        return Colors.green;

      case 'PENDING':
      case 'UNDER_REVIEW':
        return const Color(0xFFE19A00);

      case 'REJECTED':
        return AppColors.greyDark;

      case 'SUSPENDED':
        return Colors.black87;

      case 'NOT_STARTED':
        return Colors.grey;

      default:
        return AppColors.textPrimary;
    }
  }

  // =========================
  // Border
  // =========================
  Border? get badgeBorder {
    switch (normalizedStatus) {
      case 'SUSPENDED':
        return Border.all(
          color: Colors.black87,
          width: 0.8,
        );

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: badgeBorder,
      ),
      child: Text(
        displayStatus,
        style: AppTextStyles.bodySmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}