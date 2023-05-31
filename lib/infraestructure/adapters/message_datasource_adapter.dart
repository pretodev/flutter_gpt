import '../../domain/chat/message.dart';

abstract class MessageDatasourceAdapter {
  Future<Message> add(Message message);

  Future<List<Message>> getAll();
}
