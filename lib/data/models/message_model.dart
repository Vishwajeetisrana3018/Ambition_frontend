import 'package:ambition_delivery/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {required super.id,
      required super.sender,
      required super.senderModel,
      required super.receiver,
      required super.receiverModel,
      required super.message,
      required super.createdAt});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      sender: json['sender'],
      senderModel: json['senderModel'],
      receiver: json['receiver'],
      receiverModel: json['receiverModel'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': super.id,
      'sender': super.sender,
      'senderModel': super.senderModel,
      'receiver': super.receiver,
      'receiverModel': super.receiverModel,
      'message': super.message,
      'createdAt': super.createdAt.toIso8601String(),
    };
  }

  //fromEntity
  factory MessageModel.fromEntity(MessageEntity messageEntity) {
    return MessageModel(
      id: messageEntity.id,
      sender: messageEntity.sender,
      senderModel: messageEntity.senderModel,
      receiver: messageEntity.receiver,
      receiverModel: messageEntity.receiverModel,
      message: messageEntity.message,
      createdAt: messageEntity.createdAt,
    );
  }

  //toEntity
  MessageEntity toEntity() {
    return MessageEntity(
      id: super.id,
      sender: super.sender,
      senderModel: super.senderModel,
      receiver: super.receiver,
      receiverModel: super.receiverModel,
      message: super.message,
      createdAt: super.createdAt,
    );
  }
}
