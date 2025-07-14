import 'package:ambition_delivery/data/models/ride_request_model.dart';
import 'package:ambition_delivery/domain/entities/ride_with_earnings.dart';

class RideWithEarningsModel extends RideWithEarnings {
  RideWithEarningsModel(
      {required super.rideRequests,
      required super.totalEarnings,
      required super.totalRides});

  factory RideWithEarningsModel.fromJson(Map<String, dynamic> json) {
    return RideWithEarningsModel(
      rideRequests: RideRequestModel.fromJsonList(json['rideRequests']),
      totalEarnings: json['totalEarnings'],
      totalRides: json['totalCompletedRides'],
    );
  }

  factory RideWithEarningsModel.fromEntity(RideWithEarnings entity) {
    return RideWithEarningsModel(
      rideRequests: entity.rideRequests,
      totalEarnings: entity.totalEarnings,
      totalRides: entity.totalRides,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rideRequests': rideRequests
          .map((e) => RideRequestModel.fromEntity(e).toJson())
          .toList(),
      'totalEarnings': totalEarnings,
      'totalCompletedRides': totalRides,
    };
  }

  RideWithEarnings toEntity() {
    return RideWithEarnings(
      rideRequests: rideRequests,
      totalEarnings: totalEarnings,
      totalRides: totalRides,
    );
  }
}
