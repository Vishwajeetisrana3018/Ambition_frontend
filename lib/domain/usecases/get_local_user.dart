import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class GetLocalUser {
  final LocalDataRepository localUserRepository;

  GetLocalUser(this.localUserRepository);

  Map<String, dynamic>? call() {
    return localUserRepository.getLocalUser();
  }
}
