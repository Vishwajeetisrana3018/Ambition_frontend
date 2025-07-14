import 'package:ambition_delivery/domain/entities/ride_request_details.dart';
import 'package:ambition_delivery/domain/entities/vehicle_category.dart';

class SuggestedAlternativeVehicle {
  final VehicleCategory? suggestedVehicle;
  final List<VehicleCategory> alternativeVehicles;
  final RideRequestDetails? rideRequestDeails;

  SuggestedAlternativeVehicle({
    required this.suggestedVehicle,
    required this.alternativeVehicles,
    required this.rideRequestDeails,
  });
}
