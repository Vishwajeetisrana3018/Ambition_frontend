import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class SaveUserLocally {
  final LocalDataRepository repository;

  SaveUserLocally(this.repository);

  Future<void> call(Map<String, dynamic> user) async {
    return await repository.savePassenger(user);
  }
}
