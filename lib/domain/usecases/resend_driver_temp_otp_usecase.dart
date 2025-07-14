import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class ResendDriverTempOtpUsecase {
  final DriverRepository _driverRepository;

  ResendDriverTempOtpUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.resendDriverTempOtp(data);
  }
}
