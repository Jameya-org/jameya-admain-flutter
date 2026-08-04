import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya/core/utils/app_colors.dart';
import 'package:jameya/core/utils/app_text_styles.dart';

/// Horizontal row of selectable duration chips (6, 10, 12 months).
/// Chips render right-to-left in RTL matching: 6 → 10 → 12 (right to left).
class DurationSelector extends StatelessWidget {
  final int? selectedDuration;
  final ValueChanged<int> onSelected;

  static const List<int> _options = [6, 10, 12];

  const DurationSelector({
    super.key,
    required this.selectedDuration,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مدة الجمعية',
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_options.length, (i) {
            return Padding(
              // Trailing gap between chips (except the last one)
              padding: i < _options.length - 1
                  ? EdgeInsetsDirectional.only(end: 8.w)
                  : EdgeInsets.zero,
              child: _DurationChip(
                months: _options[i],
                isSelected: selectedDuration == _options[i],
                onTap: () => onSelected(_options[i]),
              ),
            );
          }),
        ),
        SizedBox(height: 8.h),
        Text(
          'عدد المشتركين سيحدد على حسب عدد الشهور',
          style: AppTextStyles.label.copyWith(color: AppColors.textHint),
        ),
      ],
    );
  }
}

class _DurationChip extends StatelessWidget {
  final int months;
  final bool isSelected;
  final VoidCallback onTap;

  const _DurationChip({
    required this.months,
    required this.isSelected,
    required this.onTap,
  });

  String get _label => months == 12 ? '12 شهر' : '$months شهور';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Text(
          _label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
