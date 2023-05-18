import 'package:flutter_gpt/domain/chat/chat_bot_service.dart';
import 'package:flutter_gpt/domain/chat/message.dart';
import 'package:flutter_gpt/infraestructure/adapters/bot_adapter.dart';

class ChatBotServiceImpl implements ChatBotService {
  final BotAdapter _bot;

  ChatBotServiceImpl({
    required BotAdapter bot,
  }) : _bot = bot;

  @override
  Stream<Message> sendMessage(Message message, List<Message> history) {
    return _bot.requestResponse([...history, message]);
  }
}
