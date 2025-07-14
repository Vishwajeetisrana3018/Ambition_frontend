import 'package:ambition_delivery/domain/entities/ride_with_earnings.dart';
import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class GetPendingRideRequestsByDriverCarCategory {
  final RideRequestRepository _rideRequestRepository;

  GetPendingRideRequestsByDriverCarCategory(this._rideRequestRepository);

  Future<RideWithEarnings?> call(String driverId) async {
    return _rideRequestRepository
        .getPendingRideRequestsByDriverCarCategory(driverId);
  }
}
