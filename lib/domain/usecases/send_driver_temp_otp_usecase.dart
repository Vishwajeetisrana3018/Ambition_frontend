import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class SendDriverTempOtpUsecase {
  final DriverRepository _driverRepository;

  SendDriverTempOtpUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.sendDriverTempOtp(data);
  }
}
