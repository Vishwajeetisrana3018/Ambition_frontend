import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class GetOtpPhoneNumberUserTypeUsecase {
  final LocalDataRepository _otpPhoneNumberRepository;

  GetOtpPhoneNumberUserTypeUsecase(this._otpPhoneNumberRepository);

  Map<String, String>? call() {
    return _otpPhoneNumberRepository.getOtpPhoneNumberAndUserType();
  }
}
