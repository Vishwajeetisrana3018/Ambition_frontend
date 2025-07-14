import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class SaveToken {
  final LocalDataRepository repository;

  SaveToken(this.repository);

  Future<void> call(String token) async {
    return await repository.saveToken(token);
  }
}
