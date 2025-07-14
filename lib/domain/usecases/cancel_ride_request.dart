import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class CancelRideRequest {
  final RideRequestRepository _rideRequestRepository;

  CancelRideRequest(this._rideRequestRepository);

  Future<void> call(String rideRequestId) async {
    await _rideRequestRepository.cancelRideRequest(rideRequestId);
  }
}
