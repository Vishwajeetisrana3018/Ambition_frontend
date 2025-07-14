import '../../domain/entities/vehicle.dart';
import 'vehicle_category_model.dart';

class VehicleModel extends Vehicle {
  VehicleModel(
      {required super.id,
      required super.vehicleName,
      required super.make,
      required super.category});

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['_id'],
      vehicleName: json['vehicleName'],
      make: json['make'],
      category: VehicleCategoryModel.fromJson(json['vehicleCategory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': super.id,
      'vehicleName': super.vehicleName,
      'make': super.make,
      'category': VehicleCategoryModel.fromEntity(super.category).toJson(),
    };
  }

  Vehicle toEntity() {
    return Vehicle(
      id: super.id,
      vehicleName: super.vehicleName,
      make: super.make,
      category: super.category,
    );
  }

  static List<VehicleModel> fromJsonList(List list) {
    return list.map((item) => VehicleModel.fromJson(item)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<VehicleModel> list) {
    return list.map((item) => item.toJson()).toList();
  }
}
