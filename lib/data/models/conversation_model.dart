import 'package:ambition_delivery/data/models/driver_model.dart';
import 'package:ambition_delivery/data/models/message_model.dart';
import 'package:ambition_delivery/data/models/participant_id_model.dart';
import 'package:ambition_delivery/data/models/user_model.dart';
import 'package:ambition_delivery/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.lastMessage,
    required super.participantId,
    required super.participantModel,
    super.userDetails,
    super.driverDetails,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: ParticipantIdModel.fromJson(json['_id']),
      lastMessage: MessageModel.fromJson(json['lastMessage']),
      participantId: json['participantId'],
      participantModel: json['participantModel'],
      userDetails: json['participantModel'] == 'User'
          ? json['participantDetails'] != null
              ? UserModel.fromJson(json['participantDetails'])
              : null
          : null,
      driverDetails: json['participantModel'] == 'Driver'
          ? json['participantDetails'] != null
              ? DriverModel.fromJson(json['participantDetails'])
              : null
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': ParticipantIdModel.fromEntity(super.id).toJson(),
      'lastMessage': MessageModel.fromEntity(super.lastMessage).toJson(),
      'participantId': super.participantId,
      'participantModel': super.participantModel,
      'userDetails': super.userDetails != null
          ? UserModel.fromEntity(super.userDetails!).toJson()
          : null,
      'driverDetails': super.driverDetails != null
          ? DriverModel.fromEntity(super.driverDetails!).toJson()
          : null,
    };
  }

  //fromEntity
  factory ConversationModel.fromEntity(ConversationEntity conversationEntity) {
    return ConversationModel(
      id: ParticipantIdModel.fromEntity(conversationEntity.id),
      lastMessage: MessageModel.fromEntity(conversationEntity.lastMessage),
      participantId: conversationEntity.participantId,
      participantModel: conversationEntity.participantModel,
      userDetails: conversationEntity.userDetails != null
          ? UserModel.fromEntity(conversationEntity.userDetails!).toEntity()
          : null,
      driverDetails: conversationEntity.driverDetails != null
          ? DriverModel.fromEntity(conversationEntity.driverDetails!).toEntity()
          : null,
    );
  }

  //toEntity
  ConversationEntity toEntity() {
    return ConversationEntity(
      id: ParticipantIdModel.fromEntity(super.id).toEntity(),
      lastMessage: MessageModel.fromEntity(super.lastMessage).toEntity(),
      participantId: super.participantId,
      participantModel: super.participantModel,
      userDetails: super.userDetails != null
          ? UserModel.fromEntity(super.userDetails!).toEntity()
          : null,
      driverDetails: super.driverDetails != null
          ? DriverModel.fromEntity(super.driverDetails!).toEntity()
          : null,
    );
  }
}
