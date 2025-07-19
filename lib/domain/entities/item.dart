class Item {
  final String id;
  final String name;
  final num length;
  final num width;
  final num height;
  final num weight;

  Item({
    required this.id,
    required this.name,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
  });

  // Factory constructor to safely build from JSON/map
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      length: json['length'] ?? 0,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
    );
  }

  // Convert object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'length': length,
      'width': width,
      'height': height,
      'weight': weight,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.id == id &&
        other.name == name &&
        other.length == length &&
        other.width == width &&
        other.height == height &&
        other.weight == weight;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      length.hashCode ^
      width.hashCode ^
      height.hashCode ^
      weight.hashCode;
}
