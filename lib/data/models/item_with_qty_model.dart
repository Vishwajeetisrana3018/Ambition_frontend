import 'package:ambition_delivery/domain/entities/item_with_qty.dart';

class ItemWithQtyModel extends ItemWithQty {
  ItemWithQtyModel(
      {required super.id,
      required super.name,
      required super.length,
      required super.width,
      required super.height,
      required super.weight,
      required super.qty});

  factory ItemWithQtyModel.fromJson(Map<String, dynamic> json) {
    return ItemWithQtyModel(
      id: json['_id'],
      name: json['name'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      weight: json['weight'],
      qty: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': super.id,
      'name': super.name,
      'length': super.length,
      'width': super.width,
      'height': super.height,
      'weight': super.weight,
      'quantity': super.qty,
    };
  }

  factory ItemWithQtyModel.fromEntity(ItemWithQty item) {
    return ItemWithQtyModel(
      id: item.id,
      name: item.name,
      length: item.length,
      width: item.width,
      height: item.height,
      weight: item.weight,
      qty: item.qty,
    );
  }

  ItemWithQty toEntity() {
    return ItemWithQty(
      id: super.id,
      name: super.name,
      length: super.length,
      width: super.width,
      height: super.height,
      weight: super.weight,
      qty: super.qty,
    );
  }
}
