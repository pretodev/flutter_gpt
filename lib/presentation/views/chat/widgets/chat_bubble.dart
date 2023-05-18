import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpt/domain/chat/message.dart';
import 'package:flutter_gpt/domain/chat/sender_type.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final Message message;

  bool get isSender => message.senderType == SenderType.user;

  @override
  Widget build(BuildContext context) {
    if (isSender) {
      return BubbleSpecialThree(
        text: message.content,
        color: const Color(0xFF1B97F3),
        tail: false,
        textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        isSender: isSender,
      );
    }

    return BubbleSpecialThree(
      text: message.content,
      color: const Color(0xFFE8E8EE),
      tail: false,
      isSender: isSender,
    );
  }
}
