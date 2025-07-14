import 'package:ambition_delivery/domain/entities/ride_request_details.dart';

class RideRequestDetailsModel extends RideRequestDetails {
  RideRequestDetailsModel(
      {required super.totalVolume,
      required super.totalWeight,
      required super.itemCounts,
      required super.peopleTagging,
      required super.distance,
      required super.time});

  factory RideRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return RideRequestDetailsModel(
      totalVolume: json['totalVolume'],
      totalWeight: json['totalWeight'],
      itemCounts: json['itemCounts'],
      peopleTagging: json['peopleTagging'],
      distance: json['distance'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalVolume': super.totalVolume,
      'totalWeight': super.totalWeight,
      'itemCounts': super.itemCounts,
      'peopleTagging': super.peopleTagging,
      'distance': super.distance,
      'time': super.time,
    };
  }

  RideRequestDetails toEntity() {
    return RideRequestDetails(
      totalVolume: super.totalVolume,
      totalWeight: super.totalWeight,
      itemCounts: super.itemCounts,
      peopleTagging: super.peopleTagging,
      distance: super.distance,
      time: super.time,
    );
  }

  factory RideRequestDetailsModel.fromEntity(RideRequestDetails entity) {
    return RideRequestDetailsModel(
      totalVolume: entity.totalVolume,
      totalWeight: entity.totalWeight,
      itemCounts: entity.itemCounts,
      peopleTagging: entity.peopleTagging,
      distance: entity.distance,
      time: entity.time,
    );
  }
}
