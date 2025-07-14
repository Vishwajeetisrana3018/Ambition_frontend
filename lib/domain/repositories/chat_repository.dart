import 'package:ambition_delivery/domain/entities/conversation_entity.dart';
import 'package:ambition_delivery/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<List<ConversationEntity>> getConversationById(String id);
  Future<void> sendMessage(Map<String, dynamic> message);
  Future<List<MessageEntity>> getChatMessagesById(
      String userId, String participantId);
}
