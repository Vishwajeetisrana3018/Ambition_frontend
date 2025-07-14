import 'package:ambition_delivery/domain/entities/driver.dart';

import '../repositories/driver_repository.dart';

class UpdateDriver {
  final DriverRepository repository;

  UpdateDriver(this.repository);

  Future<Driver> call(String id, Map<String, dynamic> driver) async {
    return await repository.updateDriver(id, driver);
  }
}
