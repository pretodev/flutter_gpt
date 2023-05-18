import 'package:flutter_gpt/domain/chat/sender_type.dart';

class Message {
  final SenderType senderType;
  final DateTime date;
  final String content;
  final bool completed;

  Message({
    required this.senderType,
    required this.content,
    DateTime? date,
    this.completed = false,
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
      completed: completed ?? this.completed,
    );
  }

  @override
  String toString() {
    return 'Message(senderType: $senderType, date: $date, content: $content, completed: $completed)';
  }
}
