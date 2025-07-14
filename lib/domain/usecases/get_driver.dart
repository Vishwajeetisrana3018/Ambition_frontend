import '../entities/driver.dart';
import '../repositories/driver_repository.dart';

class GetDriver {
  final DriverRepository repository;

  GetDriver(this.repository);

  Future<Driver?> call(String id) async {
    return await repository.getDriver(id);
  }
}
