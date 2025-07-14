import 'package:ambition_delivery/domain/entities/location_entity.dart';
import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class GetDriverLocation {
  final DriverRepository driverRepository;

  GetDriverLocation(this.driverRepository);

  Future<LocationEntity?> call(String driverId) async {
    return driverRepository.getDriverLocation(driverId);
  }
}
