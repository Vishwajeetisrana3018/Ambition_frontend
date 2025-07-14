import 'package:ambition_delivery/domain/entities/repeat_job_item_entity.dart';

class RepeatJobItemModel extends RepeatJobItemEntity {
  RepeatJobItemModel({required super.id, required super.quantity});

  factory RepeatJobItemModel.fromJson(Map<String, dynamic> json) {
    return RepeatJobItemModel(
      id: json['id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }

  //toEntity
  RepeatJobItemEntity toEntity() {
    return RepeatJobItemEntity(
      id: id,
      quantity: quantity,
    );
  }

  //fromEntity
  factory RepeatJobItemModel.fromEntity(RepeatJobItemEntity entity) {
    return RepeatJobItemModel(
      id: entity.id,
      quantity: entity.quantity,
    );
  }
}
