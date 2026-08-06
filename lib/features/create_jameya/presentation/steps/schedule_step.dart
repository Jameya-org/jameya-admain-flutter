import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/widgets/custom_button.dart';
import 'package:jameya_admin/core/widgets/custom_outlined_button.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_state.dart';
import 'package:jameya_admin/features/create_jameya/presentation/widgets/create_jameya_step_layout.dart';
import 'package:jameya_admin/features/create_jameya/presentation/widgets/date_picker_field.dart';

/// Step 1 — choose the jameya start date.
class ScheduleStep extends StatelessWidget {
  const ScheduleStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateJameyaCubit, CreateJameyaState>(
      builder: (context, state) {
        final cubit = CreateJameyaCubit.get(context);
        final canGoNext = cubit.canGoNext;

        return CreateJameyaStepLayout(
          title: 'الجدول الزمني',
          subtitle:
              'حدّد موعد البداية ودورية الدفع وعدد الدورات لتجدول الأقساط تلقائيًا.',
          currentStep: 1,
          body: DatePickerField(
            selectedDate: state.form.startDate,
            onDateSelected: cubit.setStartDate,
          ),
          footer: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  text: 'التالي',
                  onPressed: canGoNext ? cubit.nextStep : () {},
                  backgroundColor: canGoNext
                      ? AppColors.primary
                      : AppColors.grey200,
                  textColor: canGoNext ? Colors.white : AppColors.textDisabled,
                ),
                SizedBox(height: 12.h),
                CustomOutlinedButton(
                  text: 'السابق',
                  onPressed: cubit.previousStep,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
