import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class UpdateUserLocation {
  final UserRepository _userRepository;

  UpdateUserLocation(this._userRepository);

  Future<void> call(String id, Map<String, dynamic> location) async {
    return _userRepository.updateUserLocation(id, location);
  }
}
