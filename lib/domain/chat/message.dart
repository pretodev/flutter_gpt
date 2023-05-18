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
