import 'dart:convert';

import 'package:ambition_delivery/data/models/message_model.dart';
import 'package:ambition_delivery/domain/entities/message_entity.dart';
import 'package:ambition_delivery/presentation/bloc/auth_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/chat_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/socket_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/socket_state.dart';
import 'package:ambition_delivery/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatMessagesScreenArguments {
  final String participantId;
  final String participantName;
  ChatMessagesScreenArguments({
    required this.participantId,
    required this.participantName,
  });
}

class ChatMessagesScreen extends StatefulWidget {
  final ChatMessagesScreenArguments arguments;
  const ChatMessagesScreen({super.key, required this.arguments});

  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  late SocketBloc _socketBloc;
  late ChatBloc _chatBloc;
  late AuthBloc _authBloc;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController =
      ScrollController(); // Added ScrollController
  final List<MessageEntity> _messages = []; // Local message list

  @override
  void initState() {
    super.initState();
    _socketBloc = BlocProvider.of<SocketBloc>(context);
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _chatBloc.add(GetChatMessagesEvent(widget.arguments.participantId));
    // Start listening to socket events for this user
    _socketBloc.subscribeToEvents(_authBloc.currentUserId);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose(); // Dispose the ScrollController
    _socketBloc.unsubscribeFromEvents(_authBloc.currentUserId);
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      context.read<ChatBloc>().add(SendMessageEvent(
            _messageController.text.trim(),
            widget.arguments.participantId,
          ));
      _messageController.clear();
      _scrollToBottom(); // Scroll to bottom after sending a message
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments.participantName),
      ),
      body: Column(
        children: [
          Expanded(
            child: MultiBlocListener(
              listeners: [
                BlocListener<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is ChatError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    } else if (state is ChatLoaded) {
                      // Update local messages with fetched messages
                      setState(() {
                        _messages.clear();
                        _messages.addAll(state.messages);
                      });
                      _scrollToBottom(); // Scroll to bottom after loading messages
                    }
                  },
                ),
                BlocListener<SocketBloc, SocketState>(
                  listener: (context, state) {
                    if (state is SocketChatMessageReceived) {
                      final MessageEntity newMessage =
                          MessageModel.fromJson(jsonDecode(state.message))
                              .toEntity();
                      setState(() {
                        _messages.add(newMessage); // Append the new message
                      });
                      _scrollToBottom(); // Scroll to bottom for new message
                    }
                  },
                ),
              ],
              child: _buildMessageList(),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    // Group messages by date
    final groupedMessages = _groupMessagesByDate(_messages);

    return ListView.builder(
      controller: _scrollController, // Attach the ScrollController
      itemCount: groupedMessages.length,
      itemBuilder: (context, index) {
        final item = groupedMessages[index];
        if (item is String) {
          // This is a date header
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        } else if (item is MessageEntity) {
          // This is a message bubble
          final isCurrentUser = item.sender == _authBloc.currentUserId;
          return MessageBubble(
            message: item,
            isCurrentUser: isCurrentUser,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  List<dynamic> _groupMessagesByDate(List<MessageEntity> messages) {
    final groupedMessages = <dynamic>[];
    String? lastDate;
    for (var message in messages) {
      final messageDate = DateFormat('MMM d, yyyy').format(message.createdAt);
      if (lastDate != messageDate) {
        groupedMessages.add(messageDate); // Add date header
        lastDate = messageDate;
      }
      groupedMessages.add(message); // Add message
    }
    return groupedMessages;
  }
}
