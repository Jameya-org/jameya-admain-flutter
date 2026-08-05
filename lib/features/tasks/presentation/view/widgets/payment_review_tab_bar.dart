import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya/core/utils/app_colors.dart';

/// Three-button tab bar (الكل - ناجحة - فاشلة) matching Screenshot 3 exactly
class PaymentReviewTabBar extends StatelessWidget {
  const PaymentReviewTabBar({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  final String activeTab; // 'all' | 'success' | 'failed'
  final ValueChanged<String> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _TabButton(
            label: 'الكل',
            tabKey: 'all',
            isActive: activeTab == 'all',
            onTap: onTabChanged,
          ),
          SizedBox(width: 8.w),
          _TabButton(
            label: 'ناجحة',
            tabKey: 'success',
            isActive: activeTab == 'success',
            onTap: onTabChanged,
          ),
          SizedBox(width: 8.w),
          _TabButton(
            label: 'فاشلة',
            tabKey: 'failed',
            isActive: activeTab == 'failed',
            onTap: onTabChanged,
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.tabKey,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final String tabKey;
  final bool isActive;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(tabKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isActive ? AppColors.primary : const Color(0xFFDBDBDB),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
