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

  Future<void> refreshSocieties() async {
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
    List<SocietyModel> filtered = List.from(_allSocieties);

    // Filter by Tab
    if (_activeTab != 'الكل') {
      filtered = filtered.where((e) => e.status == _activeTab).toList();
    }

    // Filter by Search Query
    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.trim().toLowerCase();
      filtered = filtered.where((e) {
        final nameMatch = e.name.toLowerCase().contains(query);
        final codeMatch = e.code.toLowerCase().contains(query);
        final amountMatch = e.monthlyAmount.toString().contains(query);
        final durationMatch = e.duration.toLowerCase().contains(query);
        return nameMatch || codeMatch || amountMatch || durationMatch;
      }).toList();
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

