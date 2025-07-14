import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class SendOtpByEmailUsecase {
  final UserRepository _userRepository;

  SendOtpByEmailUsecase(this._userRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return _userRepository.sendOtpByEmail(data);
  }
}
