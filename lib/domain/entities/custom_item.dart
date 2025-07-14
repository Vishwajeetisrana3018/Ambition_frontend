class CustomItem {
  final String id;
  final String name;
  final double length;
  final double width;
  final double height;
  final double weight;
  final int quantity;

  CustomItem({
    required this.id,
    required this.name,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
    this.quantity = 1,
  });

  factory CustomItem.fromJson(Map<String, dynamic> json) {
    return CustomItem(
      id: json['_id'] as String,
      name: json['name'] as String,
      length: (json['length'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }
}
