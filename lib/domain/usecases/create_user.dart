// domain/usecases/create_user.dart
import '../repositories/user_repository.dart';

class CreateUser {
  final UserRepository repository;

  CreateUser(this.repository);

  Future<Map<String, dynamic>> call(Map<String, dynamic> user) async {
    return await repository.createUser(user);
  }
}
