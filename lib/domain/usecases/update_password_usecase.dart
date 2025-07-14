import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class UpdatePasswordUsecase {
  final UserRepository _userRepository;

  UpdatePasswordUsecase(this._userRepository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> data) async {
    return _userRepository.updatePassword(data);
  }
}
