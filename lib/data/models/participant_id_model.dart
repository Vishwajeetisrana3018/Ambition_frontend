import 'package:ambition_delivery/domain/entities/participant_id.dart';

class ParticipantIdModel extends ParticipantId {
  ParticipantIdModel(
      {required super.participantId, required super.participantModel});

  factory ParticipantIdModel.fromJson(Map<String, dynamic> json) {
    return ParticipantIdModel(
      participantId: json['participantId'],
      participantModel: json['participantModel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'participantId': super.participantId,
      'participantModel': super.participantModel,
    };
  }

  //fromEntity
  factory ParticipantIdModel.fromEntity(ParticipantId participantId) {
    return ParticipantIdModel(
      participantId: participantId.participantId,
      participantModel: participantId.participantModel,
    );
  }

  //toEntity
  ParticipantId toEntity() {
    return ParticipantId(
      participantId: super.participantId,
      participantModel: super.participantModel,
    );
  }
}
