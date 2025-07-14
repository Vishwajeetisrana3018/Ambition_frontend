part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;
  final String currentUserId;
  const ChatLoaded(this.messages, this.currentUserId);

  @override
  List<Object> get props => [messages, currentUserId];
}

final class ConversationLoaded extends ChatState {
  final List<ConversationEntity> conversations;

  const ConversationLoaded(this.conversations);

  @override
  List<Object> get props => [conversations];
}

final class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}

final class ChatMessageSent extends ChatState {}

final class ChatMessageReceived extends ChatState {
  final MessageEntity message;

  const ChatMessageReceived(this.message);

  @override
  List<Object> get props => [message];
}
