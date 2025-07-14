import 'package:ambition_delivery/domain/entities/conversation_entity.dart';
import 'package:ambition_delivery/presentation/bloc/chat_bloc.dart';
import 'package:ambition_delivery/presentation/pages/chat/chat_messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late ChatBloc _chatBloc;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatBloc.add(GetConversationEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatBloc = context.read<ChatBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
        actions: [
          //Support chat
          IconButton(
            icon: const Icon(Icons.support_agent),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(
                '/chat_messages',
                arguments: ChatMessagesScreenArguments(
                  participantId: '67611cb04c5de8f34ce2dbe2',
                  participantName: 'Support',
                ),
              )
                  .then((_) {
                _chatBloc.add(GetConversationEvent());
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ConversationLoaded) {
            return ListView.builder(
              itemCount: state.conversations.length,
              itemBuilder: (context, index) {
                final participant = state.conversations[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    leading: _buildAvatar(participant),
                    title: Text(
                      _getParticipantName(participant),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(participant.lastMessage.message),
                        Text(
                          DateFormat('MMM d, yyyy h:mm a')
                              .format(participant.lastMessage.createdAt),
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: _buildTrailingWidget(participant),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(
                        '/chat_messages',
                        arguments: ChatMessagesScreenArguments(
                            participantId: participant.id.participantId,
                            participantName: _getParticipantName(participant)),
                      )
                          .then((_) {
                        _chatBloc.add(GetConversationEvent());
                      });
                    },
                  ),
                );
              },
            );
          } else if (state is ChatError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ChatLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  Widget _buildAvatar(ConversationEntity participant) {
    if (participant.driverDetails != null) {
      return CircleAvatar(
          backgroundImage: NetworkImage(participant.driverDetails!.profile));
    } else if (participant.userDetails != null) {
      return CircleAvatar(
          backgroundImage: NetworkImage(participant.userDetails!.profile));
    } else {
      return const CircleAvatar(
        child: Icon(Icons.support_agent),
      );
    }
  }

  String _getParticipantName(ConversationEntity participant) {
    if (participant.driverDetails != null) {
      return participant.driverDetails!.name;
    } else if (participant.userDetails != null) {
      return participant.userDetails!.name;
    } else {
      return 'Support';
    }
  }

  Widget _buildTrailingWidget(ConversationEntity participant) {
    if (participant.participantModel == 'Driver') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            participant.driverDetails?.car.make ?? '',
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            participant.driverDetails?.car.model ?? '',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
