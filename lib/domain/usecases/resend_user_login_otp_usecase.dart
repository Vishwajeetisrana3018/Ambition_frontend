import '../repositories/user_repository.dart';

class ResendUserLoginOtpUsecase {
  final UserRepository userRepository;

  ResendUserLoginOtpUsecase(this.userRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await userRepository.resendUserLoginOtp(data);
  }
}
