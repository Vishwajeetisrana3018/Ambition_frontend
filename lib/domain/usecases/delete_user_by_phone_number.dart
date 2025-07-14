import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class DeleteUserByPhoneNumber {
  final UserRepository _repository;

  DeleteUserByPhoneNumber(this._repository);

  Future<void> call(String phoneNumber) async {
    return await _repository.deleteUserByPhoneNumber(phoneNumber);
  }
}
