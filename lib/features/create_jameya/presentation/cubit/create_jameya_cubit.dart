import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jameya_admin/features/create_jameya/domain/usecases/create_jameya_usecase.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_state.dart';

class CreateJameyaCubit extends Cubit<CreateJameyaState> {
  final CreateJameyaUseCase _createJameyaUseCase;

  CreateJameyaCubit(this._createJameyaUseCase)
    : super(const CreateJameyaState());

  static CreateJameyaCubit get(BuildContext context) =>
      BlocProvider.of(context);

  /// Steps 0–2 are form steps; step 3 is the success screen.
  static const int totalFormSteps = 3;

  // ─── Validation ────────────────────────────────────────────────────────────

  /// Returns true when the given step's required fields are filled.
  bool isStepValid(int step) {
    switch (step) {
      case 0:
        return state.form.isBasicInfoValid;
      case 1:
        return state.form.isScheduleValid;
      case 2:
        return true; // Review step is always valid
      default:
        return false;
    }
  }

  /// Whether the current step is complete and the user can advance.
  bool get canGoNext => isStepValid(state.currentStep);

  // ─── Navigation ────────────────────────────────────────────────────────────

  void nextStep() {
    if (!canGoNext || state.currentStep >= totalFormSteps) return;
    emit(state.copyWith(currentStep: state.currentStep + 1, clearError: true));
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(
        state.copyWith(currentStep: state.currentStep - 1, clearError: true),
      );
    }
  }

  /// Jump directly to any step (e.g. from review "edit" button).
  void goToStep(int step) {
    if (step >= 0 && step <= totalFormSteps) {
      emit(state.copyWith(currentStep: step, clearError: true));
    }
  }

  /// Resets the wizard back to its initial state.
  void reset() => emit(const CreateJameyaState());

  // ─── Form Updates ──────────────────────────────────────────────────────────

  void setDuration(int duration) {
    emit(
      state.copyWith(
        form: state.form.copyWith(duration: duration),
        clearError: true,
      ),
    );
  }

  void setInstallmentAmount(double amount) {
    emit(
      state.copyWith(
        form: state.form.copyWith(installmentAmount: amount),
        clearError: true,
      ),
    );
  }

  void setStartDate(DateTime date) {
    emit(
      state.copyWith(
        form: state.form.copyWith(startDate: date),
        clearError: true,
      ),
    );
  }

  // ─── Calculation ───────────────────────────────────────────────────────────

  /// Returns the current computed total (duration × installmentAmount).
  double? calculateTotal() => state.form.totalAmount;

  // ─── Submit ────────────────────────────────────────────────────────────────

  Future<void> submitCreateJameya() async {
    final form = state.form;
    if (!form.isBasicInfoValid || !form.isScheduleValid) return;

    emit(state.copyWith(loading: true, clearError: true));

    try {
      await _createJameyaUseCase(form.toEntity());
      emit(
        state.copyWith(
          loading: false,
          success: true,
          currentStep: totalFormSteps, // Navigate to success screen
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
