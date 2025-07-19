import 'package:ambition_delivery/domain/entities/user.dart';
import 'package:ambition_delivery/domain/usecases/delete_user.dart';
import 'package:ambition_delivery/domain/usecases/get_local_user.dart';
import 'package:ambition_delivery/domain/usecases/get_user.dart';
import 'package:ambition_delivery/domain/usecases/logout_locally.dart';
import 'package:ambition_delivery/domain/usecases/update_user.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUser getUser;
  final UpdateUser updateUser;
  final DeleteUser deleteUser;
  final LogoutLocally logoutLocally;
  final GetLocalUser getLocalUser;

  ProfileBloc(
      {required this.getUser,
      required this.updateUser,
      required this.deleteUser,
      required this.logoutLocally,
      required this.getLocalUser})
      : super(ProfileInitial()) {
    on<GetProfile>(_onGetProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<DeleteProfile>(_onDeleteProfile);
  }

  void _onGetProfile(GetProfile event, Emitter<ProfileState> emit) async {
    print("GetProfile event triggered");
    try {

      print("Fetching user profile...");
      emit(ProfileLoading());
      final lcoalUser = getLocalUser();
      final user = await getUser(lcoalUser!['id']);
      if (user != null) {
        print("User fetched: ${user.name}");
        emit(ProfileLoaded(user: user));
      } else {
        print("User not found");
        emit(const ProfileError('Failed to load user'));
      }
    } on DioException catch (e) {
      print("DioException occurred: ${e.message}");
      if (e.response != null) {

        emit(ProfileError(e.response!.data.toString()));
      } else {
        emit(ProfileError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
// void _onGetProfile(GetProfile event, Emitter<ProfileState> emit) async {
//   print("GetProfile event triggered");

//   print("Fetching user profile...");
//   emit(ProfileLoading());

//   // Fetch local user
//   final localUser = getLocalUser();
//   final userId = localUser?['id'] ; 

//   final user = await getUser(userId);
//   print("Response: $user");  // Print the full response

//   if (user != null) {
//     print("User fetched: ${user.name}");
//     emit(ProfileLoaded(user: user));
//   } else {
//     print("User not found");
//     emit(const ProfileError('Failed to load user'));
//   }
// }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      final user = await updateUser(event.id, event.user);
      emit(ProfileUpdated());
      emit(ProfileLoaded(user: user));
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.data['type'] == "USER_NOT_FOUND") {
          emit(UserNotFoundError());
        } else if (e.response!.data['type'] == "USER_DISABLED") {
          emit(UserDisabledError());
        } else {
          emit(ProfileError(e.response!.data.toString()));
        }
      } else {
        emit(ProfileError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void _onDeleteProfile(DeleteProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      await deleteUser(event.id);
      await logoutLocally();
      emit(ProfileDeleted());
    } on DioException catch (e) {
      if (e.response != null) {
        emit(ProfileError(e.response!.data.toString()));
      } else {
        emit(ProfileError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
