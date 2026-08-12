import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/core/widgets/custom_button.dart';
import 'package:jameya_admin/core/widgets/custom_outlined_button.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';

/// Step 3 — success confirmation screen.
/// No progress indicator or dismiss arrow — this is the terminal state.
class SuccessStep extends StatelessWidget {
  const SuccessStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Centered success content ───────────────────────────────────
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Success icon
                      _SuccessIcon(),
                      SizedBox(height: 28.h),

                      // Title
                      Text(
                        'تم إنشاء الجمعية بنجاح.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headline.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 14.h),

                      // Description
                      Text(
                        'تم إعداد الجمعية بنجاح، ويمكنك الآن إضافة الأعضاء والبدء في إدارتها بكل سهولة.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textHint,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Footer buttons ─────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 32.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    text: 'العودة للرئيسية',
                    onPressed: () {
                      // Reset wizard state and navigate home
                      CreateJameyaCubit.get(context).reset();
                      Navigator.of(context).maybePop();
                    },
                  ),
                  SizedBox(height: 12.h),
                  CustomOutlinedButton(
                    text: 'تفاصيل الجمعية',
                    onPressed: () {
                      // TODO: Navigate to the jameya details screen when available
                      Navigator.of(context).maybePop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Circular teal success icon — self-contained inside this file per design decision.
class _SuccessIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96.r,
      height: 96.r,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 72.r,
          height: 72.r,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.primary,
            size: 40.r,
          ),
        ),
      ),
    );
  }
}
