import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class GetToken {
  final LocalDataRepository repository;

  GetToken(this.repository);

  String? call() {
    return repository.getToken();
  }
}
