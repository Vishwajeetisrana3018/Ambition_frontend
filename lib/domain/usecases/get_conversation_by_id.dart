import 'package:ambition_delivery/domain/entities/conversation_entity.dart';
import 'package:ambition_delivery/domain/repositories/chat_repository.dart';

class GetConversationById {
  final ChatRepository chatRepository;

  GetConversationById(this.chatRepository);

  Future<List<ConversationEntity>> call(String id) async {
    return await chatRepository.getConversationById(id);
  }
}
