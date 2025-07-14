import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class ResendDriverOtpUsecase {
  final DriverRepository _driverRepository;

  ResendDriverOtpUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> otp) async {
    return await _driverRepository.resendDriverOtp(otp);
  }
}
