import 'package:ambition_delivery/domain/entities/polyline_point_entity.dart';

class PolylinePointModel extends PolylinePointEntity {
  PolylinePointModel({required super.lat, required super.lng});

  factory PolylinePointModel.fromJson(Map<String, dynamic> json) {
    return PolylinePointModel(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory PolylinePointModel.fromEntity(PolylinePointEntity entity) {
    return PolylinePointModel(
      lat: entity.lat,
      lng: entity.lng,
    );
  }

  PolylinePointEntity toEntity() {
    return PolylinePointEntity(
      lat: lat,
      lng: lng,
    );
  }
}
