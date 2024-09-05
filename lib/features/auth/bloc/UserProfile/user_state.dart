import 'package:dil_hack_e_commerce/features/auth/model/userProfile.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

// State when a user profile is successfully created
class ProfileCreated extends ProfileState {
  final CustomerProfile profile;

  ProfileCreated(this.profile);
}

class ProfileLoaded extends ProfileState {
  final CustomerProfile profile;
  ProfileLoaded(this.profile);
}

// // State when a user profile is successfully updated
// class ProfileUpdated extends ProfileState {
//   final CustomerProfile profile;

//   ProfileUpdated(this.profile);
// }

// // State when a user profile is successfully deleted
// class ProfileDeleted extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
