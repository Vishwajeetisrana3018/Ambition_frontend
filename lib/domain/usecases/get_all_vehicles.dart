import '../entities/vehicle.dart';
import '../repositories/vehicle_repository.dart';

class GetAllVehicles {
  final VehicleRepository repository;

  GetAllVehicles(this.repository);

  Future<List<Vehicle>> call() async {
    return await repository.getVehicles();
  }
}
