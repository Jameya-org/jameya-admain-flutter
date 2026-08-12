part of 'member_circles_cubit.dart';

abstract class MemberCirclesState {}

class MemberCirclesInitial extends MemberCirclesState {}

class MemberCirclesLoading extends MemberCirclesState {}

class MemberCirclesSuccess extends MemberCirclesState {
  final List<MembershipModel> memberships;

  MemberCirclesSuccess(this.memberships);
}

class MemberCirclesFailure extends MemberCirclesState {
  final String message;

  MemberCirclesFailure(this.message);
}