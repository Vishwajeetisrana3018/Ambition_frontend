import '../entities/vehicle_category.dart';
import '../repositories/vehicle_category_repository.dart';

class GetAllVehicleCategories {
  final VehicleCategoryRepository repository;

  GetAllVehicleCategories(this.repository);

  Future<List<VehicleCategory>> call() async {
    return await repository.getVehicleCategories();
  }
}
