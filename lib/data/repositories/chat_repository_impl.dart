import 'package:ambition_delivery/data/datasources/remote_data_source.dart';
import 'package:ambition_delivery/data/models/conversation_model.dart';
import 'package:ambition_delivery/data/models/message_model.dart';
import 'package:ambition_delivery/domain/entities/conversation_entity.dart';
import 'package:ambition_delivery/domain/entities/message_entity.dart';
import 'package:ambition_delivery/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final RemoteDataSource remoteDataSource;

  ChatRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<List<MessageEntity>> getChatMessagesById(
      String userId, String participantId) async {
    final response = await remoteDataSource.getChatMessagesById(
        userId: userId, participantId: participantId);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => MessageModel.fromJson(e).toEntity())
          .toList();
    } else {
      throw Exception(response.data);
    }
  }

  @override
  Future<List<ConversationEntity>> getConversationById(String id) async {
    final response = await remoteDataSource.getConversationById(id);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => ConversationModel.fromJson(e).toEntity())
          .toList();
    } else {
      throw Exception(response.data);
    }
  }

  @override
  Future<void> sendMessage(Map<String, dynamic> message) async {
    final response = await remoteDataSource.sendMessage(message);
    if (response.statusCode != 201) {
      throw Exception(response.data);
    }
  }
}
