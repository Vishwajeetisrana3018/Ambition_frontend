import 'package:ambition_delivery/domain/entities/ride_fare.dart';

class RideFareModel extends RideFare {
  RideFareModel(
      {required super.vehicleInitialServiceFee,
      required super.vehicleServiceFee,
      required super.vehicleTimeFare,
      required super.vehicleItemBasedPricing,
      required super.carTimeFare,
      required super.helpersCharge,
      required super.congestionCharge,
      required super.surcharge,
      required super.total});

  factory RideFareModel.fromJson(Map<String, dynamic> json) {
    return RideFareModel(
      vehicleInitialServiceFee: json['vehicleInitialServiceFee'],
      vehicleServiceFee: json['vehicleServiceFee'],
      vehicleTimeFare: json['vehicleTimeFare'],
      vehicleItemBasedPricing: json['vehicleItemBasedPricing'],
      carTimeFare: json['carTimeFare'],
      helpersCharge: json['helpersCharge'],
      congestionCharge: json['congestionCharge'],
      surcharge: json['surcharge'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleInitialServiceFee': super.vehicleInitialServiceFee,
      'vehicleServiceFee': super.vehicleServiceFee,
      'vehicleTimeFare': super.vehicleTimeFare,
      'vehicleItemBasedPricing': super.vehicleItemBasedPricing,
      'carTimeFare': super.carTimeFare,
      'helpersCharge': super.helpersCharge,
      'congestionCharge': super.congestionCharge,
      'surcharge': super.surcharge,
      'total': super.total,
    };
  }

  RideFare toEntity() {
    return RideFare(
      vehicleInitialServiceFee: super.vehicleInitialServiceFee,
      vehicleServiceFee: super.vehicleServiceFee,
      vehicleTimeFare: super.vehicleTimeFare,
      vehicleItemBasedPricing: super.vehicleItemBasedPricing,
      carTimeFare: super.carTimeFare,
      helpersCharge: super.helpersCharge,
      congestionCharge: super.congestionCharge,
      surcharge: super.surcharge,
      total: super.total,
    );
  }

  factory RideFareModel.fromEntity(RideFare entity) {
    return RideFareModel(
      vehicleInitialServiceFee: entity.vehicleInitialServiceFee,
      vehicleServiceFee: entity.vehicleServiceFee,
      vehicleTimeFare: entity.vehicleTimeFare,
      vehicleItemBasedPricing: entity.vehicleItemBasedPricing,
      carTimeFare: entity.carTimeFare,
      helpersCharge: entity.helpersCharge,
      congestionCharge: entity.congestionCharge,
      surcharge: entity.surcharge,
      total: entity.total,
    );
  }
}
