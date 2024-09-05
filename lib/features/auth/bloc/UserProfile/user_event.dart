part of 'user_bloc.dart';

abstract class ProfileEvent extends Equatable {}

class CreateUser extends ProfileEvent {
  final String username;
  final String email;
  final String phoneNumber;
  final String pincode;
  final String city;
  final String state;
  final String userImgPath;

  CreateUser({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.pincode,
    required this.city,
    required this.state,
    required this.userImgPath,
  });

  @override
  List<Object?> get props => [
        username,
        email,
        phoneNumber,
        pincode,
        city,
        state,
        userImgPath,
      ];
}

class FetchProfile extends ProfileEvent {
  final String userId;

  FetchProfile(this.userId);

  @override
  List<Object?> get props => [userId];
}


// class UpadteProfile extends ProfileEvent {
//   final String userId;

//   UpadteProfile(this.userId);
// }

// class DeleteProfile extends ProfileEvent {
//   final String userId;

//   DeleteProfile(this.userId);
// }
