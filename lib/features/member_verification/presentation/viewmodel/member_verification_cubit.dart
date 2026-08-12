import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jameya_admin/features/member_verification/data/models/member_verification_model.dart';
import 'package:jameya_admin/features/member_verification/data/repos/member_verification_repo.dart';
import 'package:jameya_admin/features/member_verification/presentation/viewmodel/member_verification_state.dart';

class MemberVerificationCubit extends Cubit<MemberVerificationState> {
  final MemberVerificationRepo repo;

  MemberVerificationCubit(this.repo) : super(MemberVerificationInitial());

  List<MemberVerificationModel> _members = [];
  MemberVerificationModel? _currentMember;
  List<MemberDocumentModel> _currentDocuments = [];
  double? _estimatedAmount;

  Future<void> fetchPendingMembers() async {
    emit(MemberVerificationLoading());
    try {
      _members = await repo.getPendingMembers();
      emit(MemberVerificationLoaded(_members));
    } catch (e) {
      emit(const MemberVerificationError('حدث خطأ أثناء جلب قائمة التوثيق'));
    }
  }

  void loadMemberDetails(MemberVerificationModel member) {
    _currentMember = member;
    _currentDocuments = member.documents.map((d) => d.copyWith()).toList();
    if (_currentDocuments.isNotEmpty) {
      // Expand the first document ("صورة البطاقة الشخصية") by default as shown in design Screen 2
      _currentDocuments[0] = _currentDocuments[0].copyWith(isExpanded: true);
    }
    _estimatedAmount = member.estimatedAmount;

    emit(
      MemberVerificationDetailLoaded(
        member: _currentMember!,
        documents: _currentDocuments,
        estimatedAmount: _estimatedAmount,
      ),
    );
  }

  void toggleDocumentExpanded(int index) {
    if (state is MemberVerificationDetailLoaded) {
      _currentDocuments[index] = _currentDocuments[index].copyWith(
        isExpanded: !_currentDocuments[index].isExpanded,
      );
      _emitCurrentDetail();
    }
  }

  void setDocumentStatus(int index, DocumentVerificationStatus status) {
    if (state is MemberVerificationDetailLoaded) {
      _currentDocuments[index] = _currentDocuments[index].copyWith(
        status: status,
      );
      _emitCurrentDetail();
    }
  }

  void setDocumentRejectionReason(int index, String reason) {
    if (state is MemberVerificationDetailLoaded) {
      _currentDocuments[index] = _currentDocuments[index].copyWith(
        rejectionReason: reason,
      );
      _emitCurrentDetail();
    }
  }

  void setDocumentLocalImage(int index, String imagePath) {
    if (state is MemberVerificationDetailLoaded) {
      _currentDocuments[index] = _currentDocuments[index].copyWith(
        localImagePath: imagePath,
      );
      _emitCurrentDetail();
    }
  }

  void setEstimatedAmount(double? amount) {
    if (state is MemberVerificationDetailLoaded) {
      _estimatedAmount = amount;
      _emitCurrentDetail();
    }
  }

  Future<void> submitVerification() async {
    if (state is! MemberVerificationDetailLoaded || _currentMember == null) {
      return;
    }

    final currentState = state as MemberVerificationDetailLoaded;
    emit(currentState.copyWith(isSubmitting: true));

    try {
      // 1. Review each modified document via API
      for (final doc in _currentDocuments) {
        if (doc.status != DocumentVerificationStatus.pending) {
          if (doc.id.isNotEmpty && !doc.id.startsWith('doc_')) {
            await repo.reviewDocument(
              documentId: doc.id,
              status: doc.status == DocumentVerificationStatus.approved
                  ? 'APPROVED'
                  : 'REJECTED',
              rejectionReason: doc.rejectionReason,
            );
          }
        }
      }

      // 2. Submit eligibility participation limit if entered
      if (_estimatedAmount != null && _estimatedAmount! > 0) {
        await repo.submitEligibility(
          customerId: _currentMember!.id,
          maxMonthlyInstallmentLimit: _estimatedAmount!,
        );
      }

      emit(const MemberVerificationSuccess('تم توثيق العضو بنجاح'));
    } catch (e) {
      emit(const MemberVerificationError('حدث خطأ أثناء حفظ التوثيق'));
    }
  }

  void _emitCurrentDetail() {
    if (_currentMember != null) {
      emit(
        MemberVerificationDetailLoaded(
          member: _currentMember!,
          documents: List.from(_currentDocuments),
          estimatedAmount: _estimatedAmount,
        ),
      );
    }
  }
}
