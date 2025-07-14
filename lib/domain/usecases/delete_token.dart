import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class DeleteToken {
  final LocalDataRepository repository;

  DeleteToken(this.repository);

  Future<void> call() async {
    return await repository.deleteToken();
  }
}
