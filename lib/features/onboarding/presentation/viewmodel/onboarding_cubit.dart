import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya_admin/core/routing/routes.dart';
import 'package:jameya_admin/core/services/shared_preferences_service.dart';
import 'package:jameya_admin/features/onboarding/data/models/onboarding_model.dart';
import 'package:jameya_admin/features/onboarding/presentation/viewmodel/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingInitialState());

  static OnboardingCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  bool get isLastPage => currentIndex == OnboardingModel.pageCount - 1;

  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnboardingPageChangedState(index));
  }

  Future<void> completeOnboarding(BuildContext context) async {
    await SharedPreferencesService.setOnBoardingViewed(true);
    if (context.mounted) {
      context.go(AppRoutes.kAdminLoginView);
    }
  }
}
