import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class UpdateRideRequest {
  final RideRequestRepository _rideRequestRepository;

  UpdateRideRequest(this._rideRequestRepository);

  Future<void> call(Map<String, dynamic> rideRequest, String id) async {
    return _rideRequestRepository.updateRideRequest(rideRequest, id);
  }
}
