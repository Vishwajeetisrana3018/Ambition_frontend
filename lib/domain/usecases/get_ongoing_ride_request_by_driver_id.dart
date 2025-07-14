import 'package:ambition_delivery/domain/entities/ride_request.dart';
import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class GetOngoingRideRequestByDriverId {
  final RideRequestRepository _rideRequestRepository;

  GetOngoingRideRequestByDriverId(this._rideRequestRepository);

  Future<RideRequest?> call(String driverId) async {
    return _rideRequestRepository.getOngoingRideRequestByDriverId(driverId);
  }
}
