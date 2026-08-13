import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya_admin/core/routing/routes.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/core/widgets/custom_button.dart';
import 'package:jameya_admin/core/widgets/custom_outlined_button.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_state.dart';
import 'package:jameya_admin/features/society_management/data/models/society_model.dart';

/// Step 3 — success confirmation screen.
/// No progress indicator or dismiss arrow — this is the terminal state.
class SuccessStep extends StatelessWidget {
  const SuccessStep({super.key});

  /// Builds a [SocietyModel] for the freshly created jameya from the
  /// create response ID plus the wizard form data.
  SocietyModel _buildCreatedSociety(CreateJameyaState state) {
    final String createdId = state.createdId ?? '';
    final form = state.form;
    final startDate = form.startDate;

    return SocietyModel(
      id: createdId,
      code: createdId.length > 8
          ? createdId.substring(0, 8)
          : createdId,
      name: '',
      status: 'مسودة',
      currentTurn: 1,
      monthlyAmount: form.installmentAmount ?? 0,
      startDate: startDate?.toIso8601String() ?? '',
      endDate: (startDate != null && form.duration != null)
          ? startDate
              .add(Duration(days: form.duration! * 30))
              .toIso8601String()
          : '',
      duration: '${form.duration ?? 12}',
      iconType: 'waiting',
    );
  }

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
                      // Reset wizard state and navigate to the Admin Home,
                      // replacing the create wizard stack entirely.
                      CreateJameyaCubit.get(context).reset();
                      context.go(AppRoutes.kHomeView);
                    },
                  ),
                  SizedBox(height: 12.h),
                  CustomOutlinedButton(
                    text: 'تفاصيل الجمعية',
                    onPressed: () {
                      final state = CreateJameyaCubit.get(context).state;
                      final createdId = state.createdId;

                      if (createdId == null || createdId.isEmpty) {
                        CreateJameyaCubit.get(context).reset();
                        context.go(AppRoutes.kHomeView);
                        return;
                      }

                      // Replace the wizard with the details screen so Back
                      // returns to Home instead of the creation flow.
                      context.pushReplacement(
                        AppRoutes.kSocietyDetailsView,
                        extra: _buildCreatedSociety(state),
                      );
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
