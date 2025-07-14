import 'package:ambition_delivery/domain/entities/vehicle_category.dart';

class Car {
  final VehicleCategory category;
  final String make;
  final int year;
  final String model;
  final String color;
  final String plate;

  Car({
    required this.category,
    required this.make,
    required this.year,
    required this.model,
    required this.color,
    required this.plate,
  });
}
