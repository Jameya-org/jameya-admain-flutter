import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jameya/core/utils/app_colors.dart';
import 'package:jameya/core/widgets/custom_button.dart';
import 'package:jameya/core/widgets/custom_outlined_button.dart';
import 'package:jameya/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';
import 'package:jameya/features/create_jameya/presentation/cubit/create_jameya_state.dart';
import 'package:jameya/features/create_jameya/presentation/widgets/create_jameya_step_layout.dart';
import 'package:jameya/features/create_jameya/presentation/widgets/review_card.dart';

/// Step 2 — shows a summary of all entered data for final review before submission.
class ReviewStep extends StatelessWidget {
  const ReviewStep({super.key});

  static final _numFmt = NumberFormat('#,##0', 'en_US');
  static final _dateFmt = DateFormat('d MMMM yyyy', 'ar');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateJameyaCubit, CreateJameyaState>(
      builder: (context, state) {
        final cubit = CreateJameyaCubit.get(context);
        final form = state.form;

        return CreateJameyaStepLayout(
          title: 'مراجعة البيانات',
          subtitle:
              'راجع التفاصيل قبل الإنشاء، ويمكنك تعديل أي قسم بضغطة واحدة.',
          currentStep: 2,
          body: Column(
            children: [
              // ── Basic information card ─────────────────────────────────────
              ReviewCard(
                icon: Icons.savings,
                title: 'البيانات الأساسية',
                onEdit: () => cubit.goToStep(0),
                items: [
                  ReviewCardItem(
                    label: 'مدة الجمعية',
                    value: form.duration != null
                        ? '${form.duration} ${form.duration == 12 ? "شهر" : "شهور"}'
                        : '—',
                  ),
                  ReviewCardItem(
                    label: 'قيمة الجمعية',
                    value: form.totalAmount != null
                        ? _numFmt.format(form.totalAmount!)
                        : '—',
                  ),
                  ReviewCardItem(
                    label: 'القسط الشهري',
                    value: form.installmentAmount != null
                        ? _numFmt.format(form.installmentAmount!)
                        : '—',
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // ── Schedule card ──────────────────────────────────────────────
              ReviewCard(
                icon: Icons.calendar_month,
                title: 'الجدول الزمني',
                onEdit: () => cubit.goToStep(1),
                items: [
                  ReviewCardItem(
                    label: 'تاريخ البداية',
                    value: form.startDate != null
                        ? _dateFmt.format(form.startDate!)
                        : '—',
                  ),
                ],
              ),
            ],
          ),
          footer: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // API error message
                if (state.error != null) ...[
                  Text(
                    state.error!,
                    style: TextStyle(
                      color: AppColors.error,
                      fontSize: 13.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                ],

                // Create / loading button
                CustomButton(
                  text: 'إنشاء الجمعية',
                  onPressed:
                      state.loading ? () {} : cubit.submitCreateJameya,
                  backgroundColor: state.loading
                      ? AppColors.primaryLight50
                      : AppColors.primary,
                ),
                SizedBox(height: 12.h),

                // Previous
                CustomOutlinedButton(
                  text: 'السابق',
                  onPressed: state.loading ? () {} : cubit.previousStep,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
