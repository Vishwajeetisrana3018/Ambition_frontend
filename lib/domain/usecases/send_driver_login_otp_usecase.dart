import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class SendDriverLoginOtpUsecase {
  final DriverRepository _driverRepository;

  SendDriverLoginOtpUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.sendDriverLoginOtp(data);
  }
}
