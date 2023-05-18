import '../../domain/chat/bot_response.dart';
import '../../domain/chat/message.dart';

abstract class BotAdapter {
  Stream<ChatBotResponse> requestResponse(List<Message> context);
}
