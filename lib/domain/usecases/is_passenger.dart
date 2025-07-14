import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class IsPassenger {
  final LocalDataRepository repository;

  IsPassenger(this.repository);

  bool call() {
    return repository.isPassenger();
  }
}
