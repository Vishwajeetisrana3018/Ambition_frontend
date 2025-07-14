import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class DeleteRideRequest {
  final RideRequestRepository _rideRequestRepository;

  DeleteRideRequest(this._rideRequestRepository);

  Future<void> call(String rideRequestId) async {
    return _rideRequestRepository.deleteRideRequest(rideRequestId);
  }
}
