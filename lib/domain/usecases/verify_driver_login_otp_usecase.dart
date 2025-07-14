import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class VerifyDriverLoginOtpUsecase {
  final DriverRepository _driverRepository;

  VerifyDriverLoginOtpUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.verifyDriverLoginOtp(data);
  }
}
