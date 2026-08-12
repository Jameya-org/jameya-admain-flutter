import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jameya_admin/features/home/data/repos/home_repo.dart';
import 'package:jameya_admin/features/home/presentation/manager/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  Future<void> fetchDashboardData() async {
    emit(HomeDashboardLoading());
    try {
      final dashboard = await _homeRepo.getDashboardData();
      emit(HomeDashboardLoaded(dashboard));
    } catch (e) {
      emit(HomeDashboardError(e.toString()));
    }
  }
}
