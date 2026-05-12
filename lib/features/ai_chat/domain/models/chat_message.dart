class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime createdAt;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.createdAt,
  });
}
