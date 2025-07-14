import 'package:ambition_delivery/domain/entities/vehicle_fares.dart';

class VehicleCategory {
  final String id;
  final String name;
  final String vehicleType;
  final int passengerCapacity;
  final VehicleFares? fares;

  VehicleCategory({
    required this.id,
    required this.name,
    required this.vehicleType,
    required this.passengerCapacity,
    required this.fares,
  });
}
