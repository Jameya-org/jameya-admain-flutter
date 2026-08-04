import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya/core/utils/app_colors.dart';
import 'package:jameya/core/utils/app_text_styles.dart';

/// Three-segment progress bar with step label and step number.
///
/// Segments are ordered right-to-left (RTL): segment 0 is the rightmost.
/// Segments at index ≤ [currentStep] are highlighted in teal.
class CreateJameyaProgressIndicator extends StatelessWidget {
  final int currentStep; // 0-indexed (0, 1, or 2)

  const CreateJameyaProgressIndicator({
    super.key,
    required this.currentStep,
  });

  static const List<String> _stepLabels = [
    'معلومات الجمعية',
    'الجدول الزمني',
    'مراجعة البيانات',
  ];

  @override
  Widget build(BuildContext context) {
    final safeStep = currentStep.clamp(0, 2);

    return Column(
      children: [
        // Step number (right) and step label (left) in RTL layout
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // In RTL Row, first child renders on the right → step number
            Text(
              'الخطوة ${safeStep + 1} من 3',
              style: AppTextStyles.label.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            // Last child renders on the left → step label
            Text(
              _stepLabels[safeStep],
              style: AppTextStyles.label.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // Progress segments — in RTL, index 0 is rightmost (current step)
        Row(
          children: List.generate(3, (index) {
            final isActive = index <= safeStep;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                height: 4.h,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.grey200,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
