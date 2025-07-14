import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class VerifyOtpForDriverByEmailUsecase {
  final DriverRepository _driverRepository;

  VerifyOtpForDriverByEmailUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.verifyOtpForDriverByEmail(data);
  }
}
