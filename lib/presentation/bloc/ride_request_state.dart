part of 'ride_request_bloc.dart';

sealed class RideRequestState extends Equatable {
  const RideRequestState();

  @override
  List<Object?> get props => [];
}

final class RideRequestInitial extends RideRequestState {}

final class RideRequestLoading extends RideRequestState {}

final class ItemsLoaded extends RideRequestState {
  final List<Item> items;

  const ItemsLoaded(this.items);

  @override
  List<Object> get props => [items];
}

final class RideRequestError extends RideRequestState {
  final String message;

  const RideRequestError(this.message);

  @override
  List<Object> get props => [message];
}

final class UserNotFoundError extends RideRequestState {}

final class UserDisabledError extends RideRequestState {}

final class DriverNotFoundError extends RideRequestState {}

final class DriverDisabledError extends RideRequestState {}

final class RideRequestCreated extends RideRequestState {}

final class RideRequestUpdated extends RideRequestState {}

final class RideRequestDeleted extends RideRequestState {}

final class RideRequestCancelled extends RideRequestState {}

final class RideRequestCompleted extends RideRequestState {}

final class RideRequestLoaded extends RideRequestState {
  final RideRequest rideRequest;

  const RideRequestLoaded(this.rideRequest);

  @override
  List<Object> get props => [rideRequest];
}

final class OnGoingRideRequestLoaded extends RideRequestState {
  final RideRequest rideRequest;
  final Position driverPosition;
  final LocationEntity userPosition;
  final Set<Polyline> polylines;

  const OnGoingRideRequestLoaded(
      {required this.rideRequest,
      required this.driverPosition,
      required this.userPosition,
      required this.polylines});

  @override
  List<Object> get props =>
      [rideRequest, driverPosition, userPosition, polylines];
}

final class OnGoingUserRideRequestLoaded extends RideRequestState {
  final RideRequest rideRequest;
  final LocationEntity? driverPosition;
  final LocationEntity? carDriverPosition;
  final Set<Polyline> polylines;

  const OnGoingUserRideRequestLoaded(
      {required this.rideRequest,
      required this.driverPosition,
      required this.carDriverPosition,
      required this.polylines});

  @override
  List<Object?> get props => [rideRequest, driverPosition, polylines];
}

final class RideRequestsLoaded extends RideRequestState {
  final List<RideRequest?> rideRequests;

  const RideRequestsLoaded(this.rideRequests);

  @override
  List<Object> get props => [rideRequests];
}

final class PendingRideRequestsLoaded extends RideRequestState {
  final RideWithEarnings rideRequests;

  const PendingRideRequestsLoaded(this.rideRequests);

  @override
  List<Object> get props => [rideRequests];
}

final class ClosedRideRequestsLoaded extends RideRequestState {
  final List<RideRequest?> rideRequests;

  const ClosedRideRequestsLoaded(this.rideRequests);

  @override
  List<Object> get props => [rideRequests];
}

final class NoOngoingRideRequest extends RideRequestState {}

final class NoClosedRideRequests extends RideRequestState {}

final class NoPendingRideRequests extends RideRequestState {}

final class CurrentUserLoaded extends RideRequestState {
  final Map<String, dynamic>? user;

  const CurrentUserLoaded(this.user);

  @override
  List<Object> get props => [user ?? {}];
}

final class CurrentLocationLoaded extends RideRequestState {
  final Position position;

  const CurrentLocationLoaded({required this.position});

  @override
  List<Object> get props => [position];
}

final class PolylinePointsLoaded extends RideRequestState {
  final List<PolylinePointEntity> polylinePoints;

  const PolylinePointsLoaded(this.polylinePoints);

  @override
  List<Object> get props => [polylinePoints];
}

final class DriverLocationUpdated extends RideRequestState {}

final class UserLocationUpdated extends RideRequestState {}
