import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jameya_admin/core/functions/show_image.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_images.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/core/widgets/custom_button.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_state.dart';
import 'package:jameya_admin/features/create_jameya/presentation/widgets/create_jameya_step_layout.dart';
import 'package:jameya_admin/features/create_jameya/presentation/widgets/duration_selector.dart';
import 'package:jameya_admin/features/create_jameya/presentation/widgets/installment_amount_selector.dart';

/// Step 0 — collect duration, installment amount, and displays the auto-total.
class BasicInformationStep extends StatefulWidget {
  const BasicInformationStep({super.key});

  @override
  State<BasicInformationStep> createState() => _BasicInformationStepState();
}

class _BasicInformationStepState extends State<BasicInformationStep> {
  late final TextEditingController _totalController;

  final _numberFormat = NumberFormat('#,##0', 'en_US');

  @override
  void initState() {
    super.initState();
    final form = context.read<CreateJameyaCubit>().state.form;
    _totalController = TextEditingController(
      text: form.totalAmount != null
          ? _numberFormat.format(form.totalAmount!)
          : '',
    );
  }

  @override
  void dispose() {
    _totalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateJameyaCubit, CreateJameyaState>(
      // Update total controller whenever totalAmount changes
      listenWhen: (prev, curr) =>
          prev.form.totalAmount != curr.form.totalAmount,
      listener: (context, state) {
        final total = state.form.totalAmount;
        _totalController.text = total != null
            ? _numberFormat.format(total)
            : '';
      },
      builder: (context, state) {
        final cubit = CreateJameyaCubit.get(context);
        final canGoNext = cubit.canGoNext;

        return CreateJameyaStepLayout(
          title: 'إنشاء جمعية جديدة',
          subtitle:
              'ابدأ بإدخال البيانات الأساسية للجمعية حتى تتمكن من حساب الأقساط والدورات تلقائيًا.',
          currentStep: 0,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Section header ─────────────────────────────────────────────
              _SectionHeader(),
              SizedBox(height: 24.h),

              // ── Duration ───────────────────────────────────────────────────
              DurationSelector(
                selectedDuration: state.form.duration,
                onSelected: cubit.setDuration,
              ),
              SizedBox(height: 28.h),

              // ── Installment amount ─────────────────────────────────────────
              InstallmentAmountSelector(
                selectedAmount: state.form.installmentAmount,
                onSelected: cubit.setInstallmentAmount,
              ),
              SizedBox(height: 20.h),

              // ── Total amount (read-only, auto-computed) ────────────────────
              Text(
                'قيمة الجمعية الكلية',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _totalController,
                readOnly: true,
                textAlign: TextAlign.right,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: _fieldDecoration(readOnly: true),
              ),
              SizedBox(height: 6.h),
              Text(
                'القيمة الإجمالية التي سيستلمها كل مستفيد في دورة.',
                style: AppTextStyles.label.copyWith(color: AppColors.textHint),
              ),
            ],
          ),
          footer: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
            child: CustomButton(
              text: 'التالي',
              onPressed: canGoNext ? cubit.nextStep : () {},
              backgroundColor: canGoNext
                  ? AppColors.primary
                  : AppColors.grey200,
              textColor: canGoNext ? Colors.white : AppColors.textDisabled,
            ),
          ),
        );
      },
    );
  }

  InputDecoration _fieldDecoration({bool readOnly = false}) {
    return InputDecoration(
      filled: true,
      fillColor: readOnly ? AppColors.grey100 : AppColors.surface,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.border, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.border, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}

/// "معلومات الجمعية" section header inside BasicInformationStep.
class _SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // In RTL Row: index 0 = rightmost → icon on right ✓
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(90.r),
          ),
          child: showImage(Assets.iconsWalletIcon, width: 36.w, height: 36.h),
        ),

        SizedBox(width: 8.w),
        Text(
          'معلومات الجمعية',
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
