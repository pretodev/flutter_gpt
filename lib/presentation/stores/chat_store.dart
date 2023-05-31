import 'package:flutter/material.dart';
import 'package:flutter_gpt/domain/chat/message.dart';
import 'package:flutter_gpt/presentation/stores/async_store_mixin.dart';

class ChatStore extends ChangeNotifier with AsyncStoreMixin {
  List<Message> _messages = [];
  List<Message> get messages => _messages;
  set messages(List<Message> value) {
    _messages = value;
    notifyListeners();
  }

  void insertMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }

  void setMessage(int index, Message message) {
    _messages[index] = message;
    notifyListeners();
  }
}
