import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class IsDriver {
  final LocalDataRepository repository;

  IsDriver(this.repository);

  bool call() {
    return repository.isDriver();
  }
}
