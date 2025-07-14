import 'package:ambition_delivery/domain/entities/polyline_point_entity.dart';
import 'package:ambition_delivery/domain/entities/ride_with_earnings.dart';

import '../entities/ride_request.dart';

abstract class RideRequestRepository {
  Future<void> createRideRequest(Map<String, dynamic> rideRequest);
  Future<RideRequest?> getRideRequest(String id);
  //Cancel ride request
  Future<void> cancelRideRequest(String rideId);
  //Complete ride request
  Future<void> completeRideRequest(String rideId);
  //getOngoingRideRequestByUserId
  Future<RideRequest?> getOngoingRideRequestByUserId(String userId);
  //getOngoingRideRequestByDriverId
  Future<RideRequest?> getOngoingRideRequestByDriverId(String driverId);
  //getClosedRideRequestByDriverId
  Future<List<RideRequest?>> getClosedRideRequestsByDriverId(String driverId);
  //getClosedRideRequestByUserId
  Future<List<RideRequest?>> getClosedRideRequestsByUserId(String userId);
  Future<RideWithEarnings?> getPendingRideRequestsByDriverCarCategory(
      String driverId);
  Future<List<RideRequest>> getRideRequests();
  Future<void> updateRideRequest(Map<String, dynamic> rideRequest, String id);
  Future<void> deleteRideRequest(String id);

  Future<List<PolylinePointEntity>> getPolylinePoints(
      Map<String, dynamic> data);
}
