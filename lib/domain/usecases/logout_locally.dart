import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class LogoutLocally {
  final LocalDataRepository repository;

  LogoutLocally(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}
