import 'dart:async';

import 'package:flutter_gpt/application/load_messages.dart';
import 'package:flutter_gpt/application/send_message.dart';
import 'package:flutter_gpt/domain/chat/message.dart';
import 'package:flutter_gpt/presentation/views/chat/state/chat_store.dart';

import '../../../../domain/chat/sender_type.dart';

class ChatController {
  ChatController({
    required ChatStore chatStore,
    required SendMessage sendMessage,
    required LoadMessages loadMessages,
  })  : _chatStore = chatStore,
        _sendMessage = sendMessage,
        _loadMessages = loadMessages;

  final ChatStore _chatStore;
  final SendMessage _sendMessage;
  final LoadMessages _loadMessages;

  StreamSubscription? _subscription;

  void loadMessages() async {
    await Future.delayed(const Duration(seconds: 0));
    _chatStore.loading = true;
    _chatStore.messages = await _loadMessages();
    _chatStore.loading = false;
  }

  void sendMessage(String content) async {
    _chatStore.loading = true;
    final history = [..._chatStore.messages];

    final userMsg = Message(content: content, senderType: SenderType.user);
    final botMsg = Message(content: '', senderType: SenderType.bot);
    _chatStore.insertMessage(userMsg);
    _chatStore.insertMessage(botMsg);

    final completer = Completer();
    _subscription?.cancel();
    _subscription = _sendMessage(
      userMsg,
      history: history,
    ).listen((response) {
      if (response.isCompleted) {
        completer.complete();
      }
      _chatStore.setMessage(0, response.message);
    });

    await completer.future;
    _chatStore.loading = false;
  }
}
