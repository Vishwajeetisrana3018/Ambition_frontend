import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class DeletePhoneNumberUserTypeUsecase {
  final LocalDataRepository _otpPhoneNumberRepository;

  DeletePhoneNumberUserTypeUsecase(this._otpPhoneNumberRepository);

  Future<void> call() {
    return _otpPhoneNumberRepository.deleteOtpPhoneNumberAndUserType();
  }
}
