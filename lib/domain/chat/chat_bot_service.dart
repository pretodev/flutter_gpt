import 'package:flutter_gpt/domain/chat/bot_response.dart';
import 'package:flutter_gpt/domain/chat/message.dart';

abstract class ChatBotService {
  Stream<ChatBotResponse> sendMessage(Message message, List<Message> history);
}
