import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class VerifyOtpUsecase {
  final UserRepository _otpRepository;

  VerifyOtpUsecase(this._otpRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> otp) async {
    return _otpRepository.verifyOtp(otp);
  }
}
