import 'repeat_job_custom_item_entity.dart';
import 'repeat_job_item_entity.dart';

class RepeatJobEntity {
  final String id;
  final String userId;
  final List<RepeatJobItemEntity> items;
  final List<RepeatJobCustomItemEntity> customItems;
  final int peopleTagging;
  final int requiredHelpers;
  final int pickupFloor;
  final int dropoffFloor;
  final String specialRequirements;
  final String jobType;
  final String moveType;
  final bool isRideAndMove;
  final bool isEventJob;
  final double originLat;
  final double originLong;
  final String originName;
  final String originAddress;
  final double destinationLat;
  final double destinationLong;
  final String destinationName;
  final String destinationAddress;
  final int? passengersCount;

  RepeatJobEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.customItems,
    required this.peopleTagging,
    required this.requiredHelpers,
    required this.pickupFloor,
    required this.dropoffFloor,
    required this.specialRequirements,
    required this.jobType,
    required this.moveType,
    required this.isRideAndMove,
    required this.isEventJob,
    required this.originLat,
    required this.originLong,
    required this.originName,
    required this.originAddress,
    required this.destinationLat,
    required this.destinationLong,
    required this.destinationName,
    required this.destinationAddress,
    this.passengersCount,
  });
}
