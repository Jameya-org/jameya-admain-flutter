import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';

/// Tappable field that opens a system date picker.
/// Renders the calendar icon on the right (start in RTL) matching the design.
class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  String get _formattedDate => selectedDate != null
      ? DateFormat('d MMMM yyyy', 'ar').format(selectedDate!)
      : '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تاريخ بداية الجمعية',
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _pickDate(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border, width: 1.2),
            ),
            child: Row(
              children: [
                // Calendar icon on the right (index 0 = rightmost in RTL)
                Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.textHint,
                  size: 22,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _formattedDate,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: selectedDate != null
                          ? AppColors.textPrimary
                          : AppColors.textHint,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'سيتم احتساب أول قسط من هذا التاريخ.',
          style: AppTextStyles.label.copyWith(color: AppColors.textHint),
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 2)),
      locale: const Locale('ar'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }
}
