import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/society_model.dart';
import '../../data/repos/society_repo.dart';
import 'society_state.dart';

class SocietyCubit extends Cubit<SocietyState> {
  final SocietyRepo _societyRepo;

  SocietyCubit(this._societyRepo) : super(SocietyInitial());

  List<SocietyModel> _allSocieties = [];
  String _activeTab = 'الكل';
  String _searchQuery = '';

  void fetchSocieties() async {
    emit(SocietyLoading());
    try {
      _allSocieties = await _societyRepo.getCircles();
      _emitLoadedState();
    } catch (e) {
      emit(SocietyError(e.toString()));
    }
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
      // Basic status translation logic for demo purposes, you may need to map properly
      String statusToMatch = _activeTab;
      if (_activeTab == 'نشطة') statusToMatch = 'IN_PROGRESS';
      if (_activeTab == 'مسددة') statusToMatch = 'COMPLETED';
      if (_activeTab == 'منتهية') statusToMatch = 'CANCELLED';

      filtered = filtered.where((e) => e.status == statusToMatch || e.status == _activeTab).toList();
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
