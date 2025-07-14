import '../../domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.name,
    required super.length,
    required super.width,
    required super.height,
    required super.weight,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['_id'],
      name: json['name'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'length': length,
      'width': width,
      'height': height,
      'weight': weight,
    };
  }

  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      name: item.name,
      length: item.length,
      width: item.width,
      height: item.height,
      weight: item.weight,
    );
  }

  Item toEntity() {
    return Item(
      id: id,
      name: name,
      length: length,
      width: width,
      height: height,
      weight: weight,
    );
  }

  static List<ItemModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => ItemModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<ItemModel> items) {
    return items.map((item) => item.toJson()).toList();
  }

  @override
  String toString() {
    return '$id: $name';
  }
}
