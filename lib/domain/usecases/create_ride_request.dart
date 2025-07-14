import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class CreateRideRequest {
  final RideRequestRepository _rideRequestRepository;

  CreateRideRequest(this._rideRequestRepository);

  Future<void> call(Map<String, dynamic> rideRequest) async {
    return await _rideRequestRepository.createRideRequest(rideRequest);
  }
}
