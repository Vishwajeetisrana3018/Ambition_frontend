part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class GetProfile extends ProfileEvent {}

final class UpdateProfile extends ProfileEvent {
  final String id;
  final Map<String, dynamic> user;

  const UpdateProfile({required this.id, required this.user});

  @override
  List<Object> get props => [id, user];
}

final class DeleteProfile extends ProfileEvent {
  final String id;

  const DeleteProfile({required this.id});

  @override
  List<Object> get props => [id];
}
