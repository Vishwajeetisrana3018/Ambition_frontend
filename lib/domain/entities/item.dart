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
