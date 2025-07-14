import 'package:ambition_delivery/domain/entities/suggested_alternative_vehicle.dart';

import '../repositories/vehicle_category_repository.dart';

class GetVehicleCategoriesByItems {
  final VehicleCategoryRepository _vehicleCategoryRepository;

  GetVehicleCategoriesByItems(this._vehicleCategoryRepository);

  Future<SuggestedAlternativeVehicle> call(Map<String, dynamic> items) async {
    return await _vehicleCategoryRepository.getVehicleCategoriesByItems(items);
  }
}
