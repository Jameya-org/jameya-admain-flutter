import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';

/// Horizontal row of selectable installment amount chips (1000, 2000, 3000).
/// Chips render right-to-left in RTL matching: 1000 → 2000 → 3000 (right to left).
class InstallmentAmountSelector extends StatelessWidget {
  final double? selectedAmount;
  final ValueChanged<double> onSelected;

  static const List<int> _options = [1000, 2000, 3000];

  const InstallmentAmountSelector({
    super.key,
    required this.selectedAmount,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'قيمة قسط الجمعية',
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
              child: _AmountChip(
                amount: _options[i],
                isSelected: selectedAmount == _options[i].toDouble(),
                onTap: () => onSelected(_options[i].toDouble()),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _AmountChip extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final VoidCallback onTap;

  const _AmountChip({
    required this.amount,
    required this.isSelected,
    required this.onTap,
  });

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
          '$amount جنيه',
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
