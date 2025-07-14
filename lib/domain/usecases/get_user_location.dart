import 'package:ambition_delivery/domain/entities/location_entity.dart';
import 'package:ambition_delivery/domain/repositories/user_repository.dart';

class GetUserLocation {
  final UserRepository userRepository;

  GetUserLocation(this.userRepository);

  Future<LocationEntity?> call(String driverId) async {
    return userRepository.getUserLocation(driverId);
  }
}
