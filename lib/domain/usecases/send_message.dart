import 'package:ambition_delivery/domain/repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository chatRepository;

  SendMessage(this.chatRepository);

  Future<void> call(Map<String, dynamic> message) async {
    await chatRepository.sendMessage(message);
  }
}
