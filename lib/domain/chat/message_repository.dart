import 'package:flutter_gpt/domain/chat/message.dart';

abstract class MessageRepository {
  Future<List<Message>> get all;

  Future<List<Message>> getFrom({
    int limit = 10,
    int offset = 0,
  });

  Future<void> save(Message message);
}
