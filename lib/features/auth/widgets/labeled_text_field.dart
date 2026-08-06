import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.subtitle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              '*',
              style: AppTextStyles.subtitle.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        TextFormField(
          controller: controller,
          obscureText: obscureText,
          textAlign: TextAlign.start,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hintText,

            hintStyle: AppTextStyles.subtitle.copyWith(
              color: AppColors.grey500,
            ),

            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.grey300,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}