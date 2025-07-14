import 'package:ambition_delivery/domain/entities/driver.dart';
import 'package:equatable/equatable.dart';

sealed class DriverProfileState extends Equatable {
  const DriverProfileState();

  @override
  List<Object> get props => [];
}

final class DriverProfileInitial extends DriverProfileState {}

final class DriverProfileLoading extends DriverProfileState {}

final class DriverProfileLoaded extends DriverProfileState {
  final Driver driver;

  const DriverProfileLoaded({required this.driver});
}

final class DriverProfileDeleted extends DriverProfileState {}

final class DriverProfileError extends DriverProfileState {
  final String message;

  const DriverProfileError(this.message);

  @override
  List<Object> get props => [message];
}

final class DriverProfileUpdated extends DriverProfileState {}

final class DriverNotFoundError extends DriverProfileState {}

final class DriverDisabledError extends DriverProfileState {}
