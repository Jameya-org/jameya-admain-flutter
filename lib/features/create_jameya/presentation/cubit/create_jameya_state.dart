import 'package:jameya_admin/features/create_jameya/domain/entities/create_jameya_entity.dart';

/// Holds all form fields collected across the multi-step creation wizard.
/// [totalAmount] is derived automatically from [duration] × [installmentAmount].
class CreateJameyaFormData {
  final int? duration; // Months: 6, 10, or 12
  final double? installmentAmount;
  final DateTime? startDate;

  const CreateJameyaFormData({
    this.duration,
    this.installmentAmount,
    this.startDate,
  });

  // ─── Derived values ───────────────────────────────────────────────────────

  /// Auto-computed total: duration × installmentAmount. Null when inputs are incomplete.
  double? get totalAmount {
    if (duration == null ||
        installmentAmount == null ||
        installmentAmount! <= 0) {
      return null;
    }
    return duration! * installmentAmount!;
  }

  // ─── Validation ───────────────────────────────────────────────────────────

  bool get isBasicInfoValid =>
      duration != null && installmentAmount != null && installmentAmount! > 0;

  bool get isScheduleValid => startDate != null;

  // ─── Conversion ───────────────────────────────────────────────────────────

  /// Converts to the domain entity. Only call when all fields are validated.
  CreateJameyaEntity toEntity() => CreateJameyaEntity(
    duration: duration!,
    installmentAmount: installmentAmount!,
    totalAmount: totalAmount!,
    startDate: startDate!,
  );

  CreateJameyaFormData copyWith({
    int? duration,
    double? installmentAmount,
    DateTime? startDate,
  }) {
    return CreateJameyaFormData(
      duration: duration ?? this.duration,
      installmentAmount: installmentAmount ?? this.installmentAmount,
      startDate: startDate ?? this.startDate,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

/// Single immutable state object for the entire create jameya flow.
class CreateJameyaState {
  final int
  currentStep; // 0 = basic info, 1 = schedule, 2 = review, 3 = success
  final CreateJameyaFormData form;
  final bool loading;
  final bool success;
  final String? error;

  const CreateJameyaState({
    this.currentStep = 0,
    this.form = const CreateJameyaFormData(),
    this.loading = false,
    this.success = false,
    this.error,
  });

  CreateJameyaState copyWith({
    int? currentStep,
    CreateJameyaFormData? form,
    bool? loading,
    bool? success,
    String? error,
    bool clearError = false,
  }) {
    return CreateJameyaState(
      currentStep: currentStep ?? this.currentStep,
      form: form ?? this.form,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
