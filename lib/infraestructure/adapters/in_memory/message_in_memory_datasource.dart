import 'package:flutter_gpt/domain/chat/message.dart';
import 'package:flutter_gpt/infraestructure/adapters/message_datasource_adapter.dart';

class MessageInMemoryDatasource extends MessageDatasourceAdapter {
  final _messages = <Message>[];

  @override
  Future<Message> add(Message message) async {
    _messages.insert(0, message);
    return message;
  }

  @override
  Future<List<Message>> getAll() async {
    return _messages;
  }
}
