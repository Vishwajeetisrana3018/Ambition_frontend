import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class ResendDriverLoginOtpUsecase {
  final DriverRepository _driverRepository;

  ResendDriverLoginOtpUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.resendDriverLoginOtp(data);
  }
}
