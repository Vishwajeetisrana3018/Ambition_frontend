part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

final class GetChatMessagesEvent extends ChatEvent {
  final String participantId;

  const GetChatMessagesEvent(this.participantId);

  @override
  List<Object> get props => [participantId];
}

final class GetConversationEvent extends ChatEvent {}

final class SendMessageEvent extends ChatEvent {
  final String message;
  final String participantId;

  const SendMessageEvent(this.message, this.participantId);

  @override
  List<Object> get props => [message, participantId];
}
