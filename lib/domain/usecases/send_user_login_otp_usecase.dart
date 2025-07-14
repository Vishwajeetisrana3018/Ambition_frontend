import '../repositories/user_repository.dart';

class SendUserLoginOtpUsecase {
  final UserRepository userRepository;

  SendUserLoginOtpUsecase(this.userRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return await userRepository.sendUserLoginOtp(data);
  }
}
