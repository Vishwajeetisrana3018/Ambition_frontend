import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class UpdateDriverPasswordUsecase {
  final DriverRepository _driverRepository;

  UpdateDriverPasswordUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.updateDriverPassword(data);
  }
}
