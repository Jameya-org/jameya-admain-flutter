import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/society_member_model.dart';
import '../../data/models/society_payment_model.dart';
import 'society_details_state.dart';

class SocietyDetailsCubit extends Cubit<SocietyDetailsState> {
  SocietyDetailsCubit() : super(SocietyDetailsInitial());

  List<SocietyMemberModel> _allMembers = [];
  List<SocietyPaymentModel> _allPayments = [];
  String _searchQuery = '';
  int _selectedTab = 0;

  void initDetails() {
    emit(SocietyDetailsLoading());

    _allMembers = [
      SocietyMemberModel(
        id: '1', name: 'محمد احمد علي', phone: '01234567890',
        role: 'جمعية 12,000 ج.م', turn: 'الدور الأول', status: 'مدفوع', avatar: 'assets/images/profile.png',
      ),
      SocietyMemberModel(
        id: '2', name: 'محمد احمد علي', phone: '01234567890',
        role: 'جمعية 12,000 ج.م', turn: 'الدور الرابع', status: 'مدفوع', avatar: 'assets/images/profile.png',
      ),
      SocietyMemberModel(
        id: '3', name: 'محمد احمد علي', phone: '01234567890',
        role: 'جمعية 12,000 ج.م', turn: 'الدور الرابع', status: 'مدفوع', avatar: 'assets/images/profile.png',
      ),
      SocietyMemberModel(
        id: '4', name: 'محمد احمد علي', phone: '01234567890',
        role: 'جمعية 12,000 ج.م', turn: 'الدور الرابع', status: 'معلق', avatar: 'assets/images/profile.png',
      ),
      SocietyMemberModel(
        id: '5', name: 'محمد احمد علي', phone: '01234567890',
        role: 'جمعية 12,000 ج.م', turn: 'الدور الرابع', status: 'متأخر', avatar: 'assets/images/profile.png',
      ),
    ];

    _allPayments = [
      SocietyPaymentModel(id: '1', monthName: 'يناير 2024', dueDate: '15 يناير 2024', amount: 12000, status: 'مدفوع', paidCount: 5, pendingCount: 0, lateCount: 0),
      SocietyPaymentModel(id: '2', monthName: 'فبراير 2024', dueDate: '15 فبراير 2024', amount: 12000, status: 'مدفوع', paidCount: 5, pendingCount: 0, lateCount: 0),
      SocietyPaymentModel(id: '3', monthName: 'مارس 2024', dueDate: '15 مارس 2024', amount: 12000, status: 'معلق', paidCount: 4, pendingCount: 1, lateCount: 0),
      SocietyPaymentModel(id: '4', monthName: 'أبريل 2026', dueDate: '15 أبريل 2026', amount: 12000, status: 'قادم', paidCount: 0, pendingCount: 5, lateCount: 0),
      SocietyPaymentModel(id: '5', monthName: 'أبريل 2026', dueDate: '15 أبريل 2026', amount: 12000, status: 'قادم', paidCount: 0, pendingCount: 5, lateCount: 0),
      SocietyPaymentModel(id: '6', monthName: 'أبريل 2026', dueDate: '15 أبريل 2026', amount: 12000, status: 'قادم', paidCount: 0, pendingCount: 5, lateCount: 0),
      SocietyPaymentModel(id: '7', monthName: 'أبريل 2026', dueDate: '15 أبريل 2026', amount: 12000, status: 'قادم', paidCount: 0, pendingCount: 5, lateCount: 0),
    ];

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
}
