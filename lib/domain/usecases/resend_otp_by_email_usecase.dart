import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class ResendOtpByEmailUsecase {
  final UserRepository _userRepository;

  ResendOtpByEmailUsecase(this._userRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return _userRepository.resendOtpByEmail(data);
  }
}
