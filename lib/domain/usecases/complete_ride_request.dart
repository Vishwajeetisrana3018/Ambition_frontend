import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class CompleteRideRequest {
  final RideRequestRepository _rideRequestRepository;

  CompleteRideRequest(this._rideRequestRepository);

  Future<void> call(String rideRequestId) async {
    await _rideRequestRepository.completeRideRequest(rideRequestId);
  }
}
