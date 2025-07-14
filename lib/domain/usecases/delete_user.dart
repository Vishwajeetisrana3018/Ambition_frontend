import '../repositories/user_repository.dart';

class DeleteUser {
  final UserRepository _repository;

  DeleteUser(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteUser(id);
  }
}
