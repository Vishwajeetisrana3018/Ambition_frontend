import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class VerifyDriverTempOtpUsecase {
  final DriverRepository _driverRepository;

  VerifyDriverTempOtpUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.verifyDriverTempOtp(data);
  }
}
