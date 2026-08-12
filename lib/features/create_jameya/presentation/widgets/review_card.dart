import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';

/// A data row inside a [ReviewCard].
class ReviewCardItem {
  final String label;
  final String value;

  const ReviewCardItem({required this.label, required this.value});
}

/// Review card used in the review step to display a section of data.
/// Shows a header row (icon + title + edit badge) and a list of label-value rows.
/// Each card is self-contained and reusable across screens.
class ReviewCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onEdit;
  final List<ReviewCardItem> items;

  const ReviewCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onEdit,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Card header ──────────────────────────────────────────────────
          Row(
            children: [
              // In RTL Row: index 0 = rightmost → icon + title on right ✓
              Icon(icon, color: AppColors.primary, size: 22),
              SizedBox(width: 8.w),
              Text(
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              // Edit badge on the left (end in RTL)
              _EditBadge(onTap: onEdit),
            ],
          ),
          SizedBox(height: 14.h),
          // ── Data rows ────────────────────────────────────────────────────
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // In RTL: first child = right → label ✓
                  Text(
                    item.label,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  Text(
                    item.value,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditBadge extends StatelessWidget {
  final VoidCallback onTap;

  const _EditBadge({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3CD),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          'تعديل',
          style: AppTextStyles.label.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
