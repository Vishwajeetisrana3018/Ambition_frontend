import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class SaveOtpPhoneNumberUserTypeUsecase {
  final LocalDataRepository _otpPhoneNumberRepository;

  SaveOtpPhoneNumberUserTypeUsecase(this._otpPhoneNumberRepository);

  Future<void> call(String phoneNumber, String userType) async {
    await _otpPhoneNumberRepository.savePhoneNumberAndUserType(
        phoneNumber, userType);
  }
}
