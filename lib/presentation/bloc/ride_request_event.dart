part of 'ride_request_bloc.dart';

sealed class RideRequestEvent extends Equatable {
  const RideRequestEvent();

  @override
  List<Object> get props => [];
}

final class GetItems extends RideRequestEvent {}

final class GetCurrentUserDataEvent extends RideRequestEvent {}

final class CreateRideRequestEvent extends RideRequestEvent {
  final Map<String, dynamic> rideRequest;

  const CreateRideRequestEvent({required this.rideRequest});

  @override
  List<Object> get props => [rideRequest];
}

final class UpdateRideRequestEvent extends RideRequestEvent {
  final String id;

  const UpdateRideRequestEvent({required this.id});

  @override
  List<Object> get props => [id];
}

final class DeleteRideRequestEvent extends RideRequestEvent {
  final String id;

  const DeleteRideRequestEvent({required this.id});

  @override
  List<Object> get props => [id];
}

final class GetRideRequestEvent extends RideRequestEvent {
  final String id;

  const GetRideRequestEvent({required this.id});

  @override
  List<Object> get props => [id];
}

final class GetRideRequestsEvent extends RideRequestEvent {}

final class GetOngoingRideRequestByUserIdEvent extends RideRequestEvent {}

final class GetPendingRideRequestsByDriverCarCategoryEvent
    extends RideRequestEvent {}

final class GetOngoingRideRequestByDriverIdEvent extends RideRequestEvent {}

final class GetClosedRideRequestsByDriverIdEvent extends RideRequestEvent {}

final class GetClosedRideRequestsByUserIdEvent extends RideRequestEvent {}

final class FetchCurrentLocationEvent extends RideRequestEvent {}

final class GetPolylinePointsEvent extends RideRequestEvent {
  final Map<String, dynamic> data;

  const GetPolylinePointsEvent({required this.data});

  @override
  List<Object> get props => [data];
}

final class CancelRideRequestEvent extends RideRequestEvent {
  final String rideId;

  const CancelRideRequestEvent({required this.rideId});

  @override
  List<Object> get props => [rideId];
}

final class CompleteRideRequestEvent extends RideRequestEvent {
  final String rideId;

  const CompleteRideRequestEvent({required this.rideId});

  @override
  List<Object> get props => [rideId];
}

final class UpdateDriverLocationEvent extends RideRequestEvent {}

final class UpdateUserLocationEvent extends RideRequestEvent {}
