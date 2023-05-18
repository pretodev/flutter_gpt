import 'package:flutter_gpt/domain/chat/message.dart';

abstract class ChatBotService {
  Stream<Message> sendMessage(Message message, List<Message> history);
}
