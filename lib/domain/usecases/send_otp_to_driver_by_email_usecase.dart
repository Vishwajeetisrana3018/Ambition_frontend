import 'package:ambition_delivery/domain/repositories/driver_repository.dart';

class SendOtpToDriverByEmailUsecase {
  final DriverRepository _driverRepository;

  SendOtpToDriverByEmailUsecase(this._driverRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await _driverRepository.sendOtpToDriverByEmail(data);
  }
}
