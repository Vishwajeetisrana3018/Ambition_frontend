import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class UpdateDriverLocation {
  final DriverRepository _driverRepository;

  UpdateDriverLocation(this._driverRepository);

  Future<void> call(String id, Map<String, dynamic> location) async {
    return _driverRepository.updateDriverLocation(id, location);
  }
}
