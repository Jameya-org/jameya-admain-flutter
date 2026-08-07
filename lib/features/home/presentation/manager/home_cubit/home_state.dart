import 'package:jameya_admin/features/home/data/models/dashboard_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeDashboardLoading extends HomeState {}

class HomeDashboardLoaded extends HomeState {
  final DashboardModel dashboard;

  HomeDashboardLoaded(this.dashboard);
}

class HomeDashboardError extends HomeState {
  final String message;

  HomeDashboardError(this.message);
}
