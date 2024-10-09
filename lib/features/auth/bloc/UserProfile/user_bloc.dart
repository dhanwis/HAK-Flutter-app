import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/userProfile_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/UserProfile/user_state.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiService repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<CreateUser>((event, emit) async {
      emit(ProfileLoading());
      try {
        // Save profile using repository
        final profile = await repository.createCustomerProfile(
          username: event.username,
          email: event.email,
          phoneNumber: event.phoneNumber,
          pincode: event.pincode,
          city: event.city,
          state: event.state,
          userImgPath: event.userImgPath,
        );
        // Emit ProfileCreated with the saved profile
        emit(ProfileCreated(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await repository.getProfileData(event);

        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    // on<UpdateUser>((event, emit) async {
    //     emit(UserLoading());
    //     try {
    //       final user = await repository.updateUser(event.user);
    //       emit(UserUpdated(user));
    //     } catch (e) {
    //       emit(UserError(e.toString()));
    //     }
    //   });

    //   on<DeleteUser>((event, emit) async {
    //     emit(UserLoading());
    //     try {
    //       await repository.deleteUser(event.userId);
    //       emit(UserDeleted());
    //     } catch (e) {
    //       emit(UserError(e.toString()));
    //     }
    //   });
  }
}
