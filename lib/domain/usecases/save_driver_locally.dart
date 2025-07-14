import 'package:ambition_delivery/domain/repositories/local_data_repository.dart';

class SaveDriverLocally {
  final LocalDataRepository repository;

  SaveDriverLocally(this.repository);

  Future<void> call(Map<String, dynamic> driver) async {
    return await repository.saveDriver(driver);
  }
}
