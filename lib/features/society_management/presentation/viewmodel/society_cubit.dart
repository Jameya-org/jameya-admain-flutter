import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/society_model.dart';
import 'society_state.dart';

class SocietyCubit extends Cubit<SocietyState> {
  SocietyCubit() : super(SocietyInitial());

  List<SocietyModel> _allSocieties = [];
  String _activeTab = 'الكل';
  String _searchQuery = '';

  void fetchSocieties() async {
    emit(SocietyLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulate network

    _allSocieties = [
      SocietyModel(
        id: '1',
        name: 'جمعية شهر 12',
        code: 'JMY-2024-001',
        status: 'نشطة',
        currentTurn: 5,
        monthlyAmount: 1000,
        startDate: '01/12/2024',
        endDate: '01/12/2024',
        duration: '12/08',
        iconType: 'completed',
      ),
      SocietyModel(
        id: '2',
        name: 'جمعية شهر 12',
        code: 'JMY-2024-001',
        status: 'مسددة',
        currentTurn: 5,
        monthlyAmount: 1000,
        startDate: '01/12/2024',
        endDate: '01/12/2024',
        duration: '12/08',
        iconType: 'waiting',
      ),
      SocietyModel(
        id: '3',
        name: 'جمعية شهر 12',
        code: 'JMY-2024-001',
        status: 'نشطة',
        currentTurn: 5,
        monthlyAmount: 1000,
        startDate: '01/12/2024',
        endDate: '01/12/2024',
        duration: '12/08',
        iconType: 'late',
      ),
      SocietyModel(
        id: '4',
        name: 'جمعية شهر 12',
        code: 'JMY-2024-001',
        status: 'منتهية',
        currentTurn: 5,
        monthlyAmount: 1000,
        startDate: '01/12/2024',
        endDate: '01/12/2024',
        duration: '12/08',
        iconType: 'completed',
      ),
    ];
    _emitLoadedState();
  }

  void search(String query) {
    _searchQuery = query;
    _emitLoadedState();
  }

  void changeTab(String tab) {
    _activeTab = tab;
    _emitLoadedState();
  }

  void _emitLoadedState() {
    List<SocietyModel> filtered = _allSocieties;

    // Filter by Tab
    if (_activeTab != 'الكل') {
      filtered = filtered.where((e) => e.status == _activeTab).toList();
    }

    // Filter by Search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (e) =>
                e.name.contains(_searchQuery) || e.code.contains(_searchQuery),
          )
          .toList();
    }

    emit(
      SocietyLoaded(
        societies: filtered,
        activeTab: _activeTab,
        searchQuery: _searchQuery,
      ),
    );
  }
}
