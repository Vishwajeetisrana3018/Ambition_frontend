import 'package:ambition_delivery/domain/entities/repeat_job_custom_item_entity.dart';

class RepeatJobCustomItemModel extends RepeatJobCustomItemEntity {
  RepeatJobCustomItemModel({
    required super.name,
    required super.length,
    required super.width,
    required super.height,
    required super.weight,
    required super.quantity,
  });

  factory RepeatJobCustomItemModel.fromJson(Map<String, dynamic> json) {
    return RepeatJobCustomItemModel(
      name: json['name'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      weight: json['weight'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'length': length,
      'width': width,
      'height': height,
      'weight': weight,
      'quantity': quantity,
    };
  }

  //toEntity
  RepeatJobCustomItemEntity toEntity() {
    return RepeatJobCustomItemEntity(
      name: name,
      length: length,
      width: width,
      height: height,
      weight: weight,
      quantity: quantity,
    );
  }

  //fromEntity
  factory RepeatJobCustomItemModel.fromEntity(
      RepeatJobCustomItemEntity entity) {
    return RepeatJobCustomItemModel(
      name: entity.name,
      length: entity.length,
      width: entity.width,
      height: entity.height,
      weight: entity.weight,
      quantity: entity.quantity,
    );
  }
}
