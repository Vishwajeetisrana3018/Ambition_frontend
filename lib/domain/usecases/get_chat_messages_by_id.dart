import 'package:ambition_delivery/domain/entities/message_entity.dart';
import 'package:ambition_delivery/domain/repositories/chat_repository.dart';

class GetChatMessagesById {
  final ChatRepository _chatRepository;

  GetChatMessagesById(this._chatRepository);

  Future<List<MessageEntity>> call(String userId, String participantId) async {
    return _chatRepository.getChatMessagesById(userId, participantId);
  }
}
