import 'package:ambition_delivery/domain/usecases/delete_driver.dart';
import 'package:ambition_delivery/domain/usecases/get_driver.dart';
import 'package:ambition_delivery/domain/usecases/get_local_user.dart';
import 'package:ambition_delivery/domain/usecases/logout_locally.dart';
import 'package:ambition_delivery/domain/usecases/update_driver.dart';
import 'package:ambition_delivery/presentation/bloc/driver_profile_event.dart';
import 'package:ambition_delivery/presentation/bloc/driver_profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverProfileBloc extends Bloc<DriverProfileEvent, DriverProfileState> {
  final GetDriver getDriver;
  final UpdateDriver updateDriver;
  final DeleteDriver deleteDriver;

  final LogoutLocally logoutLocally;
  final GetLocalUser getLocalUser;

  DriverProfileBloc(
      {required this.getDriver,
      required this.updateDriver,
      required this.deleteDriver,
      required this.logoutLocally,
      required this.getLocalUser})
      : super(DriverProfileInitial()) {
    on<GetDriverProfile>(_onGetDriverProfile);
    on<UpdateDriverProfile>(_onUpdateDriverProfile);
    on<DeleteDriverProfile>(_onDeleteDriverProfile);
  }

  // void _onGetDriverProfile(
  //     GetDriverProfile event, Emitter<DriverProfileState> emit) async {
  //   try {
  //     emit(DriverProfileLoading());
  //     final localUser = getLocalUser();
  //     final driver = await getDriver(localUser!['id']??"677fdc0fa4b694f1a20c2508");
  //     if (driver != null) {
  //       emit(DriverProfileLoaded(driver: driver));
  //     } else {
  //       emit(const DriverProfileError('Failed to load driver'));
  //     }
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       if (e.response!.data['type'] == "DRIVER_NOT_FOUND") {
  //         emit(DriverNotFoundError());
  //       } else if (e.response!.data['type'] == "DRIVER_DISABLED") {
  //         emit(DriverDisabledError());
  //       } else {
  //         emit(DriverProfileError(e.response!.data.toString()));
  //       }
  //     } else {
  //       emit(DriverProfileError(e.message ?? 'An error occurred'));
  //     }
  //   } catch (e) {
  //     emit(DriverProfileError(e.toString()));
  //   }
  // }
void _onGetDriverProfile(
    GetDriverProfile event, Emitter<DriverProfileState> emit) async {
  emit(DriverProfileLoading());

  final localUser = getLocalUser();
  print("Fetching driver profile...");
  print("Local user: $localUser");

  // Fallback to default user ID if localUser or localUser['id'] is null
  final userId = localUser?['id'] ?? "6736028b68fccd29d02e1758";
  print("Using user ID: $userId");

  final driver = await getDriver(userId);
  print("Fetched driver: $driver");

  if (driver != null) {
    emit(DriverProfileLoaded(driver: driver));
  } else {
    print("Failed to load driver.");
    emit(const DriverProfileError('Failed to load driver'));
  }
}


  void _onUpdateDriverProfile(
      UpdateDriverProfile event, Emitter<DriverProfileState> emit) async {
    try {
      emit(DriverProfileLoading());
      final driver = await updateDriver(event.id, event.driver);
      emit(DriverProfileUpdated());
      emit(DriverProfileLoaded(driver: driver));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(DriverProfileError(e.response!.data.toString()));
      } else {
        emit(DriverProfileError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(DriverProfileError(e.toString()));
    }
  }

  void _onDeleteDriverProfile(
      DeleteDriverProfile event, Emitter<DriverProfileState> emit) async {
    try {
      emit(DriverProfileLoading());
      await deleteDriver(event.id);
      emit(DriverProfileDeleted());
    } on DioException catch (e) {
      if (e.response != null) {
        emit(DriverProfileError(e.response!.data.toString()));
      } else {
        emit(DriverProfileError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(DriverProfileError(e.toString()));
    }
  }
}
