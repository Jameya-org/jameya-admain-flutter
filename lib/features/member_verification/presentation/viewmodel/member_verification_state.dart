import 'package:jameya_admin/features/member_verification/data/models/member_verification_model.dart';

abstract class MemberVerificationState {
  const MemberVerificationState();
}

class MemberVerificationInitial extends MemberVerificationState {}

class MemberVerificationLoading extends MemberVerificationState {}

class MemberVerificationLoaded extends MemberVerificationState {
  final List<MemberVerificationModel> members;
  const MemberVerificationLoaded(this.members);
}

class MemberVerificationDetailLoaded extends MemberVerificationState {
  final MemberVerificationModel member;
  final List<MemberDocumentModel> documents;
  final double? estimatedAmount;
  final bool isSubmitting;

  const MemberVerificationDetailLoaded({
    required this.member,
    required this.documents,
    this.estimatedAmount,
    this.isSubmitting = false,
  });

  MemberVerificationDetailLoaded copyWith({
    MemberVerificationModel? member,
    List<MemberDocumentModel>? documents,
    double? estimatedAmount,
    bool? isSubmitting,
  }) {
    return MemberVerificationDetailLoaded(
      member: member ?? this.member,
      documents: documents ?? this.documents,
      estimatedAmount: estimatedAmount ?? this.estimatedAmount,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class MemberVerificationSuccess extends MemberVerificationState {
  final String message;
  const MemberVerificationSuccess(this.message);
}

class MemberVerificationError extends MemberVerificationState {
  final String message;
  const MemberVerificationError(this.message);
}
