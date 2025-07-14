import '../repositories/driver_repository.dart';

class CreateDriver {
  final DriverRepository repository;

  CreateDriver(this.repository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> driver) async {
    return await repository.createDriver(driver);
  }
}
