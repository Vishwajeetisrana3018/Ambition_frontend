import 'package:ambition_delivery/domain/entities/ride_request.dart';

class RideWithEarnings {
  List<RideRequest> rideRequests;
  num totalEarnings;
  num totalRides;

  RideWithEarnings({
    required this.rideRequests,
    required this.totalEarnings,
    required this.totalRides,
  });
}
