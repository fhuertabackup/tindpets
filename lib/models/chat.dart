
class ChatMatch {
  final String id;
  final String petName;
  final String petImageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isUnread;

  ChatMatch({
    required this.id,
    required this.petName,
    required this.petImageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    this.isUnread = false,
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}
