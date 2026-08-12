import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/society_member_model.dart';
import '../../data/models/society_payment_model.dart';
import '../../data/repos/society_repo.dart';
import 'society_details_state.dart';

class SocietyDetailsCubit extends Cubit<SocietyDetailsState> {
  final SocietyRepo _societyRepo;

  SocietyDetailsCubit(this._societyRepo) : super(SocietyDetailsInitial());

  List<SocietyMemberModel> _allMembers = [];
  List<SocietyPaymentModel> _allPayments = [];
  String _searchQuery = '';
  int _selectedTab = 0;

  Future<void> initDetails([String? circleId]) async {
    emit(SocietyDetailsLoading());

    try {
      if (circleId != null && circleId.isNotEmpty) {
        final details = await _societyRepo.getCircleDetails(circleId);
        if (details.containsKey('memberships') && details['memberships'] is List) {
          final rawMembers = details['memberships'] as List;
          if (rawMembers.isNotEmpty) {
            _allMembers = rawMembers
                .map((e) => SocietyMemberModel.fromJson(e as Map<String, dynamic>))
                .toList();
          }
        }

        final installments = await _societyRepo.getInstallments();
        if (installments.isNotEmpty) {
          _allPayments = installments;
        }
      }
    } catch (_) {}

    // Fallback data if API has no members/payments yet
    if (_allMembers.isEmpty) {
      _allMembers = _getMockMembers();
    }
    if (_allPayments.isEmpty) {
      _allPayments = _getMockPayments();
    }

    _emitState();
  }

  void changeTab(int tabIndex) {
    _selectedTab = tabIndex;
    _emitState();
  }

  void searchMember(String query) {
    _searchQuery = query;
    _emitState();
  }

  void _emitState() {
    List<SocietyMemberModel> filteredMembers = _allMembers;
    if (_searchQuery.isNotEmpty) {
      filteredMembers = filteredMembers
          .where((m) => m.name.contains(_searchQuery) || m.phone.contains(_searchQuery))
          .toList();
    }

    emit(SocietyDetailsLoaded(
      members: filteredMembers,
      payments: _allPayments,
      memberSearchQuery: _searchQuery,
      selectedTabIndex: _selectedTab,
    ));
  }

  List<SocietyMemberModel> _getMockMembers() {
    return [
      SocietyMemberModel(
        id: '1', name: 'محمد احمد علي', phone: '01234567890',
        role: 'جمعية 12,000 ج.م', turn: 'الدور الأول', status: 'مدفوع', avatar: 'assets/images/profile.png',
      ),
      SocietyMemberModel(
        id: '2', name: 'محمود حسن رياد', phone: '01000000011',
        role: 'جمعية 12,000 ج.م', turn: 'الدور الثاني', status: 'مدفوع', avatar: 'assets/images/profile.png',
      ),
    ];
  }

  List<SocietyPaymentModel> _getMockPayments() {
    return [
      SocietyPaymentModel(id: '1', monthName: 'يناير 2024', dueDate: '15 يناير 2024', amount: 12000, status: 'مدفوع', paidCount: 5, pendingCount: 0, lateCount: 0),
      SocietyPaymentModel(id: '2', monthName: 'فبراير 2024', dueDate: '15 فبراير 2024', amount: 12000, status: 'مدفوع', paidCount: 5, pendingCount: 0, lateCount: 0),
    ];
  }

  Future<bool> cancelCircle(String circleId, {String reason = 'إلغاء بواسطة الأدمن'}) async {
    try {
      await _societyRepo.cancelCircle(circleId, reason: reason);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> pauseCircle(String circleId) async {
    try {
      await _societyRepo.updateCircleStatus(circleId, status: 'SUSPENDED', reason: 'إيقاف مؤقت');
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> finishCircle(String circleId) async {
    try {
      await _societyRepo.updateCircleStatus(circleId, status: 'COMPLETED', reason: 'إنهاء الجمعية');
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> activateCircle(String circleId) async {
    try {
      await _societyRepo.activateCircle(circleId);
      return true;
    } catch (_) {
      return false;
    }
  }
}

