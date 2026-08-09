part of 'members_cubit.dart';

abstract class MembersState {}

class MembersInitial extends MembersState {}

class MembersLoading extends MembersState {}

class MembersSuccess extends MembersState {
  final List<MemberModel> members;

  MembersSuccess(this.members);
}

class MembersFailure extends MembersState {
  final String message;

  MembersFailure(this.message);
}