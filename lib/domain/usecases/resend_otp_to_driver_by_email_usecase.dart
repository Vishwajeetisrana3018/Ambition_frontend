import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class ResendOtpToDriverByEmailUsecase {
  final DriverRepository _driverRepository;

  ResendOtpToDriverByEmailUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.resendOtpToDriverByEmail(data);
  }
}
