import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../ models/member_model.dart';
import '../../../../core/services/services_locator.dart';
import '../../data/members_service.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  MembersCubit() : super(MembersInitial());

  String _search = '';
  String? _status;
  String? _kycStatus;

  Future<void> getMembers({int page = 1}) {
    return _loadMembers(showLoading: true, page: page);
  }

  /// Re-fetches the current member list without emitting a full loading
  /// state, so pull-to-refresh keeps the list visible while refreshing.
  /// Preserves the active search query and status filters.
  Future<void> refresh() {
    return _loadMembers(showLoading: false, page: 1);
  }

  Future<void> _loadMembers({
    required bool showLoading,
    required int page,
  }) async {
    if (showLoading) emit(MembersLoading());

    try {
      final members = await getIt<MembersService>().getMembers(
        page: page,
        search: _search.isEmpty ? null : _search,
        status: _status,
        kycStatus: _kycStatus,
      );

      if (isClosed) return;
      emit(MembersSuccess(members));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(
        MembersFailure(
          e.response?.data.toString() ?? 'حدث خطأ أثناء تحميل الأعضاء',
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(MembersFailure(e.toString()));
    }
  }

  void searchMembers(String value) {
    _search = value;
    getMembers();
  }

  void filterAll() {
    _status = null;
    _kycStatus = null;
    getMembers();
  }

  void filterApproved() {
    _status = 'ACTIVE';
    _kycStatus = 'APPROVED';
    getMembers();
  }

  void filterPending() {
    _status = 'ACTIVE';
    _kycStatus = 'PENDING';
    getMembers();
  }

  void filterRejected() {
    _status = 'ACTIVE';
    _kycStatus = 'REJECTED';
    getMembers();
  }
}
