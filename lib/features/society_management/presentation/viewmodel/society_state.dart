import 'package:jameya/features/society_management/data/models/society_model.dart';

abstract class SocietyState {}

class SocietyInitial extends SocietyState {}

class SocietyLoading extends SocietyState {}

class SocietyLoaded extends SocietyState {
  final List<SocietyModel> societies;
  final String activeTab;
  final String searchQuery;

  SocietyLoaded({
    required this.societies,
    required this.activeTab,
    required this.searchQuery,
  });
}
