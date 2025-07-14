import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class SendUserTempOtpUsecase {
  final UserRepository userRepository;

  SendUserTempOtpUsecase(this.userRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> otp) async {
    return await userRepository.sendUserTempOtp(otp);
  }
}
