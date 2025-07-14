import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class VerifyOtpByEmailUsecase {
  final UserRepository _userRepository;

  VerifyOtpByEmailUsecase(this._userRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return _userRepository.verifyOtpByEmail(data);
  }
}
