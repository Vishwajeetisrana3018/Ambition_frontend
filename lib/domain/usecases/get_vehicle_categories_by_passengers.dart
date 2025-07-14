import 'package:ambition_delivery/domain/entities/suggested_alternative_vehicle.dart';

import '../repositories/vehicle_category_repository.dart';

class GetVehicleCategoriesByPassengers {
  final VehicleCategoryRepository _vehicleCategoryRepository;

  GetVehicleCategoriesByPassengers(this._vehicleCategoryRepository);

  Future<SuggestedAlternativeVehicle> call(
      Map<String, dynamic> passengerCapacity) async {
    return await _vehicleCategoryRepository
        .getVehicleCategoriesByPassengerCapacity(passengerCapacity);
  }
}
