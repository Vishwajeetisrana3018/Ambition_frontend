import 'package:ambition_delivery/data/models/ride_request_details_model.dart';
import 'package:ambition_delivery/domain/entities/suggested_alternative_vehicle.dart';

import 'vehicle_category_model.dart';

class SuggestedAlternativeVehicleModel extends SuggestedAlternativeVehicle {
  SuggestedAlternativeVehicleModel(
      {required super.suggestedVehicle,
      required super.alternativeVehicles,
      required super.rideRequestDeails});

  factory SuggestedAlternativeVehicleModel.fromJson(Map<String, dynamic> json) {
    return SuggestedAlternativeVehicleModel(
      suggestedVehicle: json['suggestedVehicle'] != null
          ? VehicleCategoryModel.fromJson(json['suggestedVehicle'])
          : null,
      alternativeVehicles: (json['alternativeVehicles'] as List)
          .map((e) => VehicleCategoryModel.fromJson(e))
          .toList(),
      rideRequestDeails: json['requestDetails'] != null
          ? RideRequestDetailsModel.fromJson(json['requestDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'suggestedVehicle': (suggestedVehicle as VehicleCategoryModel).toJson(),
      'alternativeVehicles': alternativeVehicles
          .map((e) => (e as VehicleCategoryModel).toJson())
          .toList(),
      'requestDetails': (rideRequestDeails as RideRequestDetailsModel).toJson(),
    };
  }

  // to entity
  SuggestedAlternativeVehicle toEntity() {
    return SuggestedAlternativeVehicle(
      suggestedVehicle: suggestedVehicle,
      alternativeVehicles: alternativeVehicles,
      rideRequestDeails: rideRequestDeails,
    );
  }

  // from entity
  factory SuggestedAlternativeVehicleModel.fromEntity(
      SuggestedAlternativeVehicle entity) {
    return SuggestedAlternativeVehicleModel(
      suggestedVehicle: entity.suggestedVehicle,
      alternativeVehicles: entity.alternativeVehicles,
      rideRequestDeails: entity.rideRequestDeails,
    );
  }
}
