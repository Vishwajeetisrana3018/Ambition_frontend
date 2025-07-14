import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUser {
  final UserRepository _repository;

  GetUser(this._repository);

  Future<User?> call(String id) async {
    return await _repository.getUser(id);
  }
}
