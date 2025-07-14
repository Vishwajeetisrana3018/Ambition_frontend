part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final User user;

  const ProfileLoaded({required this.user});
}

final class ProfileDeleted extends ProfileState {}

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

final class ProfileUpdated extends ProfileState {}

final class UserNotFoundError extends ProfileState {}

final class UserDisabledError extends ProfileState {}
