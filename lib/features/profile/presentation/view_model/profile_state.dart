abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final Map<String, dynamic> data;

  ProfileSuccess(this.data);
}

class ProfileFailure extends ProfileState {
  final String message;

  ProfileFailure(this.message);
}
class ProfilePasswordSuccess extends ProfileState {}