part of 'member_details_cubit.dart';

sealed class MemberDetailsState {}

final class MemberDetailsInitial extends MemberDetailsState {}

final class MemberDetailsLoading extends MemberDetailsState {}

final class MemberDetailsSuccess extends MemberDetailsState {
  final MemberDetailsModel member;

  MemberDetailsSuccess(this.member);
}

final class MemberDetailsFailure extends MemberDetailsState {
  final String message;

  MemberDetailsFailure(this.message);
}