import 'package:equatable/equatable.dart';

sealed class DriverProfileEvent extends Equatable {
  const DriverProfileEvent();

  @override
  List<Object> get props => [];
}

final class GetDriverProfile extends DriverProfileEvent {}

final class UpdateDriverProfile extends DriverProfileEvent {
  final String id;
  final Map<String, dynamic> driver;

  const UpdateDriverProfile({required this.id, required this.driver});

  @override
  List<Object> get props => [id, driver];
}

final class DeleteDriverProfile extends DriverProfileEvent {
  final String id;

  const DeleteDriverProfile({required this.id});

  @override
  List<Object> get props => [id];
}
