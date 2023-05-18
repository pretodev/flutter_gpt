import '../../domain/chat/message.dart';

abstract class BotAdapter {
  Stream<Message> requestResponse(List<Message> context);
}
