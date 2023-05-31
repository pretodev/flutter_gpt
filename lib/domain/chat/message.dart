import 'package:flutter_gpt/domain/chat/sender_type.dart';

class Message {
  final SenderType senderType;
  final DateTime date;
  final String content;

  Message({
    required this.senderType,
    required this.content,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  factory Message.user(String content) => Message(
        senderType: SenderType.user,
        content: content,
      );

  factory Message.bot(String content) => Message(
        senderType: SenderType.bot,
        content: content,
      );

  Message copyWith({
    SenderType? senderType,
    DateTime? date,
    String? content,
    bool? completed,
  }) {
    return Message(
      senderType: senderType ?? this.senderType,
      date: date ?? this.date,
      content: content ?? this.content,
    );
  }
}
