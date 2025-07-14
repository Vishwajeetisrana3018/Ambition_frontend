import '../repositories/driver_repository.dart';

class DeleteDriver {
  final DriverRepository repository;

  DeleteDriver(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteDriver(id);
  }
}
