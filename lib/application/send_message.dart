import 'dart:async';

import 'package:flutter_gpt/domain/chat/chat_bot_service.dart';
import 'package:flutter_gpt/domain/chat/message.dart';
import 'package:flutter_gpt/domain/chat/message_repository.dart';

class SendMessage {
  final ChatBotService _chatService;
  final MessageRepository _messageRepository;

  SendMessage({
    required ChatBotService chatService,
    required MessageRepository messageRepository,
  })  : _chatService = chatService,
        _messageRepository = messageRepository;

  Stream<Message> call(
    Message message, {
    List<Message> history = const [],
  }) async* {
    await _messageRepository.save(message);
    yield* _chatService
        .sendMessage(message, history)
        .asyncMap((newMessage) async {
      if (newMessage.completed) {
        await _messageRepository.save(newMessage);
      }
      return newMessage;
    });
  }
}
