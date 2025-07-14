import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<User> call(String id, Map<String, dynamic> user) async {
    return await repository.updateUser(id, user);
  }
}
