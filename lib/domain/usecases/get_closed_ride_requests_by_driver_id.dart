import 'package:ambition_delivery/domain/entities/ride_request.dart';
import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class GetClosedRideRequestsByDriverId {
  final RideRequestRepository _rideRequestRepository;

  GetClosedRideRequestsByDriverId(this._rideRequestRepository);

  Future<List<RideRequest?>> call(String driverId) async {
    return _rideRequestRepository.getClosedRideRequestsByDriverId(driverId);
  }
}
