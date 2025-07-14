import 'package:ambition_delivery/domain/entities/vehicle_fares.dart';

class VehicleFaresModel extends VehicleFares {
  VehicleFaresModel(
      {required super.initialServiceFee,
      required super.serviceFee,
      required super.itemBasedPricing,
      required super.timeFare,
      required super.helpersCharge,
      required super.congestionCharge,
      required super.surcharge,
      required super.eventFare});

// Add the following factory method to the VehicleFaresModel class:
  factory VehicleFaresModel.fromJson(Map<String, dynamic> json) {
    return VehicleFaresModel(
      initialServiceFee: json['initialServiceFee'],
      serviceFee: json['serviceFee'],
      itemBasedPricing: json['itemBasedPricing'],
      timeFare: json['timeFare'],
      helpersCharge: json['helpersCharge'],
      congestionCharge: json['congestionCharge'],
      surcharge: json['surcharge'],
      eventFare: json['eventFare'],
    );
  }

// Add the following toJson method to the VehicleFaresModel class:
  Map<String, dynamic> toJson() {
    return {
      'initialServiceFee': super.initialServiceFee,
      'serviceFee': super.serviceFee,
      'itemBasedPricing': super.itemBasedPricing,
      'timeFare': super.timeFare,
      'helpersCharge': super.helpersCharge,
      'congestionCharge': super.congestionCharge,
      'surcharge': super.surcharge,
      'eventFare': super.eventFare,
    };
  }

// Add the following toEntity method to the VehicleFaresModel class:
  VehicleFares toEntity() {
    return VehicleFares(
      initialServiceFee: super.initialServiceFee,
      serviceFee: super.serviceFee,
      itemBasedPricing: super.itemBasedPricing,
      timeFare: super.timeFare,
      helpersCharge: super.helpersCharge,
      congestionCharge: super.congestionCharge,
      surcharge: super.surcharge,
      eventFare: super.eventFare,
    );
  }

  // Add the following fromEntity method to the VehicleFaresModel class:
  static VehicleFaresModel fromEntity(VehicleFares entity) {
    return VehicleFaresModel(
      initialServiceFee: entity.initialServiceFee,
      serviceFee: entity.serviceFee,
      itemBasedPricing: entity.itemBasedPricing,
      timeFare: entity.timeFare,
      helpersCharge: entity.helpersCharge,
      congestionCharge: entity.congestionCharge,
      surcharge: entity.surcharge,
      eventFare: entity.eventFare,
    );
  }
}
