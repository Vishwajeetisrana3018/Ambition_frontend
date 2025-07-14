import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class VerifyDriverOtpUsecase {
  final DriverRepository _driverRepository;

  VerifyDriverOtpUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> otp) async {
    return await _driverRepository.verifyDriverOtp(otp);
  }
}
