import 'vehicle_category.dart';

class Vehicle {
  final String id;
  final String vehicleName;
  final String make;
  final VehicleCategory category;

  Vehicle({
    required this.id,
    required this.vehicleName,
    required this.make,
    required this.category,
  });
}
