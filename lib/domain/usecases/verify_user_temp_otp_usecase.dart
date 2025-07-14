import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class VerifyUserTempOtpUsecase {
  final UserRepository userRepository;

  VerifyUserTempOtpUsecase(this.userRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> otp) async {
    return await userRepository.verifyUserTempOtp(otp);
  }
}
