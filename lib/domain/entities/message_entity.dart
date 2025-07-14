class MessageEntity {
  final String id;
  final String sender;
  final String senderModel;
  final String receiver;
  final String receiverModel;
  final String message;
  final DateTime createdAt;

  MessageEntity({
    required this.id,
    required this.sender,
    required this.senderModel,
    required this.receiver,
    required this.receiverModel,
    required this.message,
    required this.createdAt,
  });
}
