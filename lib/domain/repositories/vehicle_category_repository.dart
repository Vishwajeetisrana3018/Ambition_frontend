import 'package:ambition_delivery/domain/entities/suggested_alternative_vehicle.dart';

import '../entities/vehicle_category.dart';

abstract class VehicleCategoryRepository {
  Future<void> createVehicleCategory(Map<String, dynamic> vehicleCategory);
  Future<VehicleCategory?> getVehicleCategory(String id);
  Future<SuggestedAlternativeVehicle> getVehicleCategoriesByItems(
      Map<String, dynamic> items);
  Future<SuggestedAlternativeVehicle> getVehicleCategoriesByPassengerCapacity(
      Map<String, dynamic> passengerCapacity);
  Future<List<VehicleCategory>> getVehicleCategories();
  Future<VehicleCategory> updateVehicleCategory(
      Map<String, dynamic> vehicleCategory);
  Future<void> deleteVehicleCategory(String id);
}
