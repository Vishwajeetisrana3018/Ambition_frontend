import '../../domain/entities/repeat_job_entity.dart';
import 'repeat_job_custom_item_model.dart';
import 'repeat_job_item_model.dart';

class RepeatJobModel extends RepeatJobEntity {
  RepeatJobModel({
    required super.id,
    required super.userId,
    required List<RepeatJobItemModel> super.items,
    required List<RepeatJobCustomItemModel> super.customItems,
    required super.peopleTagging,
    required super.requiredHelpers,
    required super.pickupFloor,
    required super.dropoffFloor,
    required super.specialRequirements,
    required super.jobType,
    required super.moveType,
    required super.isRideAndMove,
    required super.isEventJob,
    required super.originLat,
    required super.originLong,
    required super.originName,
    required super.originAddress,
    required super.destinationLat,
    required super.destinationLong,
    required super.destinationName,
    required super.destinationAddress,
    super.passengersCount,
  });

  factory RepeatJobModel.fromJson(Map<String, dynamic> json) {
    return RepeatJobModel(
      id: json['_id'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((e) => RepeatJobItemModel.fromJson(e))
          .toList(),
      customItems: (json['customItems'] as List)
          .map((e) => RepeatJobCustomItemModel.fromJson(e))
          .toList(),
      peopleTagging: json['peopleTagging'],
      requiredHelpers: json['requiredHelpers'],
      pickupFloor: json['pickupFloor'],
      dropoffFloor: json['dropoffFloor'],
      specialRequirements: json['specialRequirements'],
      jobType: json['jobType'],
      moveType: json['moveType'],
      isRideAndMove: json['isRideAndMove'],
      isEventJob: json['isEventJob'],
      originLat: json['originLat'],
      originLong: json['originLong'],
      originName: json['originName'],
      originAddress: json['originAddress'],
      destinationLat: json['destinationLat'],
      destinationLong: json['destinationLong'],
      destinationName: json['destinationName'],
      destinationAddress: json['destinationAddress'],
      passengersCount: json['passengersCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'items': items.map((e) => (e as RepeatJobItemModel).toJson()).toList(),
      'customItems': customItems
          .map((e) => (e as RepeatJobCustomItemModel).toJson())
          .toList(),
      'peopleTagging': peopleTagging,
      'requiredHelpers': requiredHelpers,
      'pickupFloor': pickupFloor,
      'dropoffFloor': dropoffFloor,
      'specialRequirements': specialRequirements,
      'jobType': jobType,
      'moveType': moveType,
      'isRideAndMove': isRideAndMove,
      'isEventJob': isEventJob,
      'originLat': originLat,
      'originLong': originLong,
      'originName': originName,
      'originAddress': originAddress,
      'destinationLat': destinationLat,
      'destinationLong': destinationLong,
      'destinationName': destinationName,
      'destinationAddress': destinationAddress,
      'passengersCount': passengersCount,
    };
  }

  //toEntity
  RepeatJobEntity toEntity() {
    return RepeatJobEntity(
      id: id,
      userId: userId,
      items: items.map((e) => (e as RepeatJobItemModel).toEntity()).toList(),
      customItems: customItems
          .map((e) => (e as RepeatJobCustomItemModel).toEntity())
          .toList(),
      peopleTagging: peopleTagging,
      requiredHelpers: requiredHelpers,
      pickupFloor: pickupFloor,
      dropoffFloor: dropoffFloor,
      specialRequirements: specialRequirements,
      jobType: jobType,
      moveType: moveType,
      isRideAndMove: isRideAndMove,
      isEventJob: isEventJob,
      originLat: originLat,
      originLong: originLong,
      originName: originName,
      originAddress: originAddress,
      destinationLat: destinationLat,
      destinationLong: destinationLong,
      destinationName: destinationName,
      destinationAddress: destinationAddress,
      passengersCount: passengersCount,
    );
  }

  //fromEntity
  factory RepeatJobModel.fromEntity(RepeatJobEntity entity) {
    return RepeatJobModel(
      id: entity.id,
      userId: entity.userId,
      items: entity.items.map((e) => RepeatJobItemModel.fromEntity(e)).toList(),
      customItems: entity.customItems
          .map((e) => RepeatJobCustomItemModel.fromEntity(e))
          .toList(),
      peopleTagging: entity.peopleTagging,
      requiredHelpers: entity.requiredHelpers,
      pickupFloor: entity.pickupFloor,
      dropoffFloor: entity.dropoffFloor,
      specialRequirements: entity.specialRequirements,
      jobType: entity.jobType,
      moveType: entity.moveType,
      isRideAndMove: entity.isRideAndMove,
      isEventJob: entity.isEventJob,
      originLat: entity.originLat,
      originLong: entity.originLong,
      originName: entity.originName,
      originAddress: entity.originAddress,
      destinationLat: entity.destinationLat,
      destinationLong: entity.destinationLong,
      destinationName: entity.destinationName,
      destinationAddress: entity.destinationAddress,
      passengersCount: entity.passengersCount,
    );
  }
}
