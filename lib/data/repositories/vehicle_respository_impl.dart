import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/vehicle_model.dart';

class VehicleRespositoryImpl implements VehicleRepository {
  final RemoteDataSource vehicleRemoteDataSource;

  VehicleRespositoryImpl({
    required this.vehicleRemoteDataSource,
  });

  @override
  Future<void> createVehicle(Map<String, dynamic> vehicle) async {
    await vehicleRemoteDataSource.createVehicle(vehicle);
  }

  @override
  Future<void> deleteVehicle(String id) async {
    await vehicleRemoteDataSource.deleteVehicle(id);
  }

  @override
  Future<Vehicle?> getVehicle(String id) async {
    final resp = await vehicleRemoteDataSource.getVehicle(id);
    if (resp.statusCode == 200) {
      return VehicleModel.fromJson(resp.data).toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<Vehicle> updateVehicle(Map<String, dynamic> vehicle) async {
    final resp = await vehicleRemoteDataSource.updateVehicle(vehicle);
    return VehicleModel.fromJson(resp.data).toEntity();
  }

  @override
  Future<List<Vehicle>> getVehicles() async {
    final resp = await vehicleRemoteDataSource.getVehicles();
    return VehicleModel.fromJsonList(resp.data)
        .map((e) => e.toEntity())
        .toList();
  }
}
