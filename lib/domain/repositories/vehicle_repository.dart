import '../entities/vehicle.dart';

abstract class VehicleRepository {
  Future<void> createVehicle(Map<String, dynamic> vehicle);
  Future<Vehicle?> getVehicle(String id);
  Future<List<Vehicle>> getVehicles();
  Future<Vehicle> updateVehicle(Map<String, dynamic> vehicle);
  Future<void> deleteVehicle(String id);
}
