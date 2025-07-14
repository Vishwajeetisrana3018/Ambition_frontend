import 'package:ambition_delivery/domain/entities/conversation_entity.dart';
import 'package:ambition_delivery/domain/entities/message_entity.dart';
import 'package:ambition_delivery/domain/usecases/get_chat_messages_by_id.dart';
import 'package:ambition_delivery/domain/usecases/get_conversation_by_id.dart';
import 'package:ambition_delivery/domain/usecases/get_local_user.dart';
import 'package:ambition_delivery/domain/usecases/send_message.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatMessagesById getChatMessagesById;
  final GetConversationById getConversationById;
  final SendMessage sendMessage;
  final GetLocalUser getLocalUser;
  ChatBloc({
    required this.getChatMessagesById,
    required this.getConversationById,
    required this.sendMessage,
    required this.getLocalUser,
  }) : super(ChatInitial()) {
    on<GetChatMessagesEvent>(_onGetChatMessages);
    on<GetConversationEvent>(_onGetConversation);
    on<SendMessageEvent>(_onSendMessage);
  }

  void _onGetChatMessages(
      GetChatMessagesEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      final user = getLocalUser();
      final messages =
          await getChatMessagesById(user!['id'], event.participantId);
      emit(ChatLoaded(messages, user['id']));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(ChatError(e.response!.data.toString()));
      } else {
        emit(ChatError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void _onGetConversation(
      GetConversationEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      final user = getLocalUser();
      final conversations = await getConversationById(user!['id']);
      emit(ConversationLoaded(conversations));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(ChatError(e.response!.data.toString()));
      } else {
        emit(ChatError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      final user = getLocalUser();
      Map<String, dynamic> message = {
        'sender': user!['id'],
        'receiver': event.participantId,
        'message': event.message,
      };
      await sendMessage(message);
      emit(ChatMessageSent());
    } on DioException catch (e) {
      if (e.response != null) {
        emit(ChatError(e.response!.data.toString()));
      } else {
        emit(ChatError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
