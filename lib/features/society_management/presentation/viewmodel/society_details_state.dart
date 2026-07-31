import '../../data/models/society_member_model.dart';
import '../../data/models/society_payment_model.dart';

abstract class SocietyDetailsState {}

class SocietyDetailsInitial extends SocietyDetailsState {}

class SocietyDetailsLoading extends SocietyDetailsState {}

class SocietyDetailsLoaded extends SocietyDetailsState {
  final List<SocietyMemberModel> members;
  final List<SocietyPaymentModel> payments;
  final String memberSearchQuery;
  final int selectedTabIndex;

  SocietyDetailsLoaded({
    required this.members,
    required this.payments,
    required this.memberSearchQuery,
    required this.selectedTabIndex,
  });
}
