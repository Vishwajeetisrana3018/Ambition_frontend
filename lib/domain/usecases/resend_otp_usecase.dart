import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class ResendOtpUsecase {
  final UserRepository _otpRepository;

  ResendOtpUsecase(this._otpRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> otp) async {
    return _otpRepository.resendOtp(otp);
  }
}
