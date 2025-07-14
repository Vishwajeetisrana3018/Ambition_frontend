import 'package:ambition_delivery/domain/entities/ride_request.dart';
import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class GetOngoingRideRequestByUserId {
  final RideRequestRepository _rideRequestRepository;

  GetOngoingRideRequestByUserId(this._rideRequestRepository);

  Future<RideRequest?> call(String userId) async {
    return _rideRequestRepository.getOngoingRideRequestByUserId(userId);
  }
}
