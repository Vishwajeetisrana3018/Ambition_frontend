import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class DeleteDriverByPhoneNumber {
  final DriverRepository _driverRepository;

  DeleteDriverByPhoneNumber(this._driverRepository);

  Future<void> call(String phoneNumber) async {
    return await _driverRepository.deleteDriverByPhoneNumber(phoneNumber);
  }
}
