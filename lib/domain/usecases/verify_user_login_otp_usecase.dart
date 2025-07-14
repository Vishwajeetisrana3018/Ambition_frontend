import '../repositories/user_repository.dart';

class VerifyUserLoginOtpUsecase {
  final UserRepository userRepository;

  VerifyUserLoginOtpUsecase(this.userRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await userRepository.verifyUserLoginOtp(data);
  }
}
