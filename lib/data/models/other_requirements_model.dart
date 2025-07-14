import 'package:ambition_delivery/domain/entities/other_requirements_entity.dart';

class OtherRequirementsModel extends OtherRequirementsEntity {
  OtherRequirementsModel(
      {required super.pickupFloor,
      required super.dropoffFloor,
      required super.requiredHelpers,
      required super.peopleTaggingAlong,
      required super.specialRequirements});

  factory OtherRequirementsModel.fromJson(Map<String, dynamic> json) {
    return OtherRequirementsModel(
      pickupFloor: json['pickupFloor'],
      dropoffFloor: json['dropoffFloor'],
      requiredHelpers: json['requiredHelpers'],
      peopleTaggingAlong: json['peopleTaggingAlong'],
      specialRequirements: json['specialRequirements'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pickupFloor': super.pickupFloor,
      'dropoffFloor': super.dropoffFloor,
      'requiredHelpers': super.requiredHelpers,
      'peopleTaggingAlong': super.peopleTaggingAlong,
      'specialRequirements': super.specialRequirements,
    };
  }

  OtherRequirementsEntity toEntity() {
    return OtherRequirementsEntity(
      pickupFloor: super.pickupFloor,
      dropoffFloor: super.dropoffFloor,
      requiredHelpers: super.requiredHelpers,
      peopleTaggingAlong: super.peopleTaggingAlong,
      specialRequirements: super.specialRequirements,
    );
  }

  factory OtherRequirementsModel.fromEntity(OtherRequirementsEntity entity) {
    return OtherRequirementsModel(
      pickupFloor: entity.pickupFloor,
      dropoffFloor: entity.dropoffFloor,
      requiredHelpers: entity.requiredHelpers,
      peopleTaggingAlong: entity.peopleTaggingAlong,
      specialRequirements: entity.specialRequirements,
    );
  }
}
