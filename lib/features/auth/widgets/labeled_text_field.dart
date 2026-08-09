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
    return SizedBox(
      width: double.infinity,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // =========================
            // Label
            // =========================
            Align(
              alignment: Alignment.centerRight,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: label,
                      style: AppTextStyles.subtitle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '*',
                      style: AppTextStyles.subtitle.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),

            SizedBox(height: 8.h),

            // =========================
            // Text Field
            // =========================
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: hintText,
                hintTextDirection: TextDirection.rtl,

                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.grey500,
                ),

                // RTL:
                // prefixIcon = RIGHT
                // suffixIcon = LEFT
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
        ),
      ),
    );
  }
}