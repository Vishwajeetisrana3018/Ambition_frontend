import 'package:ambition_delivery/domain/entities/ride_request.dart';
import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class GetClosedRideRequestsByUserId {
  final RideRequestRepository _rideRequestRepository;

  GetClosedRideRequestsByUserId(this._rideRequestRepository);

  Future<List<RideRequest?>> call(String driverId) async {
    return _rideRequestRepository.getClosedRideRequestsByUserId(driverId);
  }
}
