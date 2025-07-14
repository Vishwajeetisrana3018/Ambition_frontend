import 'package:ambition_delivery/domain/entities/custom_item.dart';

class CustomItemModel extends CustomItem {
  CustomItemModel(
      {required super.id,
      required super.name,
      required super.length,
      required super.width,
      required super.height,
      required super.weight,
      super.quantity = 1});

  factory CustomItemModel.fromJson(Map<String, dynamic> json) {
    return CustomItemModel(
      id: json['_id'],
      name: json['name'],
      length: (json['length'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'length': super.length,
      'width': super.width,
      'height': super.height,
      'weight': super.weight,
      'quantity': super.quantity,
    };
  }

  CustomItem toEntity() {
    return CustomItem(
      id: super.id,
      name: super.name,
      length: super.length,
      width: super.width,
      height: super.height,
      weight: super.weight,
      quantity: super.quantity,
    );
  }

  factory CustomItemModel.fromEntity(CustomItem entity) {
    return CustomItemModel(
      id: entity.id,
      name: entity.name,
      length: entity.length,
      width: entity.width,
      height: entity.height,
      weight: entity.weight,
      quantity: entity.quantity,
    );
  }
}
