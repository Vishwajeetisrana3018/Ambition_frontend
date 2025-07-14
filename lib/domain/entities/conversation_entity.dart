import 'package:ambition_delivery/domain/entities/driver.dart';
import 'package:ambition_delivery/domain/entities/message_entity.dart';
import 'package:ambition_delivery/domain/entities/participant_id.dart';
import 'package:ambition_delivery/domain/entities/user.dart';

class ConversationEntity {
  final ParticipantId id;
  final MessageEntity lastMessage;
  final String participantId;
  final String participantModel;
  final User? userDetails;
  final Driver? driverDetails;

  ConversationEntity({
    required this.id,
    required this.lastMessage,
    required this.participantId,
    required this.participantModel,
    this.userDetails,
    this.driverDetails,
  });
}
