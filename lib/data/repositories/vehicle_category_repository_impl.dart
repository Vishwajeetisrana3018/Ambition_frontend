import 'package:ambition_delivery/data/models/suggested_alternative_vehicle_model.dart';
import 'package:ambition_delivery/data/models/vehicle_category_model.dart';
import 'package:ambition_delivery/domain/entities/suggested_alternative_vehicle.dart';

import '../../domain/entities/vehicle_category.dart';
import '../../domain/repositories/vehicle_category_repository.dart';
import '../datasources/remote_data_source.dart';

class VehicleCategoryRepositoryImpl implements VehicleCategoryRepository {
  final RemoteDataSource remoteDataSource;

  VehicleCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createVehicleCategory(
      Map<String, dynamic> vehicleCategory) async {
    await remoteDataSource.createVehicleCategory(vehicleCategory);
  }

  @override
  Future<void> deleteVehicleCategory(String id) async {
    await remoteDataSource.deleteVehicleCategory(id);
  }

  @override
  Future<VehicleCategory?> getVehicleCategory(String id) async {
    final response = await remoteDataSource.getVehicleCategory(id);
    if (response.statusCode == 200) {
      return VehicleCategoryModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<List<VehicleCategory>> getVehicleCategories() async {
    final response = await remoteDataSource.getVehicleCategories();
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => VehicleCategoryModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<SuggestedAlternativeVehicle> getVehicleCategoriesByItems(
      Map<String, dynamic> items) async {
    final response = await remoteDataSource.getVehicleCategoriesByItems(items);
    return SuggestedAlternativeVehicleModel.fromJson(response.data).toEntity();
  }

  @override
  Future<SuggestedAlternativeVehicle> getVehicleCategoriesByPassengerCapacity(
      Map<String, dynamic> passengerCapacity) async {
    final response = await remoteDataSource
        .getVehicleCategoriesByPassengerCapacity(passengerCapacity);
    return SuggestedAlternativeVehicleModel.fromJson(response.data).toEntity();
  }

  @override
  Future<VehicleCategory> updateVehicleCategory(
      Map<String, dynamic> vehicleCategory) async {
    final response =
        await remoteDataSource.updateVehicleCategory(vehicleCategory);
    return VehicleCategoryModel.fromJson(response.data);
  }
}
