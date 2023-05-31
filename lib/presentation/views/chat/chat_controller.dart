import 'dart:async';

import 'package:flutter_gpt/application/get_messages.dart';
import 'package:flutter_gpt/application/send_message.dart';
import 'package:flutter_gpt/domain/chat/message.dart';
import 'package:flutter_gpt/presentation/stores/chat_store.dart';

class ChatController {
  ChatController({
    required ChatStore chatStore,
    required SendMessage sendMessage,
    required GetMessages loadMessages,
  })  : _chatStore = chatStore,
        _sendMessage = sendMessage,
        _loadMessages = loadMessages;

  final ChatStore _chatStore;
  final SendMessage _sendMessage;
  final GetMessages _loadMessages;

  StreamSubscription? _subscription;

  void loadMessages() async {
    await Future.delayed(const Duration(seconds: 0));
    _chatStore.enableLoading();
    _chatStore.messages = await _loadMessages();
    _chatStore.disableLoading();
  }

  void sendMessage(String content) async {
    _chatStore.enableLoading();
    final history = [..._chatStore.messages];
    final userMsg = Message.user(content);
    _chatStore.insertMessage(userMsg);

    _chatStore.insertMessage(Message.bot(''));

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
    _chatStore.disableLoading();
  }
}
