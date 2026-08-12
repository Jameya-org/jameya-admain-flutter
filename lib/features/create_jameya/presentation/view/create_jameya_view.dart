import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:jameya_admin/core/animations/smart_animate_transition.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_state.dart';
import 'package:jameya_admin/features/create_jameya/presentation/steps/basic_information_step.dart';
import 'package:jameya_admin/features/create_jameya/presentation/steps/review_step.dart';
import 'package:jameya_admin/features/create_jameya/presentation/steps/schedule_step.dart';
import 'package:jameya_admin/features/create_jameya/presentation/steps/success_step.dart';

/// Root page for the create jameya wizard.
/// Switches between steps using [AnimatedSwitcher] with the app's
/// standard [SmartAnimateTransition] (slide + fade, 300 ms ease-out).
class CreateJameyaView extends StatelessWidget {
  const CreateJameyaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: BlocBuilder<CreateJameyaCubit, CreateJameyaState>(
          // Only switch widgets when the step changes
          buildWhen: (prev, curr) =>
              prev.currentStep != curr.currentStep ||
              prev.loading != curr.loading ||
              prev.error != curr.error,
          builder: (context, state) {
            return ModalProgressHUD(
              // Shown only while the Create Jameya API request is running.
              inAsyncCall: state.loading,
              child: AnimatedSwitcher(
                duration: SmartAnimateTransition.duration,
                transitionBuilder: SmartAnimateTransition.transitionBuilder,
                child: _buildStep(state.currentStep),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 0:
        return const BasicInformationStep(key: ValueKey(0));
      case 1:
        return const ScheduleStep(key: ValueKey(1));
      case 2:
        return const ReviewStep(key: ValueKey(2));
      case 3:
        return const SuccessStep(key: ValueKey(3));
      default:
        return const BasicInformationStep(key: ValueKey(0));
    }
  }
}
