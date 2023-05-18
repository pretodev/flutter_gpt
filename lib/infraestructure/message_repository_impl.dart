import 'package:flutter_gpt/domain/chat/message.dart';
import 'package:flutter_gpt/domain/chat/message_repository.dart';
import 'package:flutter_gpt/infraestructure/adapters/message_datasource_adapter.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageDatasourceAdapter _messageDatasource;

  MessageRepositoryImpl({
    required MessageDatasourceAdapter messageDatasource,
  }) : _messageDatasource = messageDatasource;

  @override
  Future<List<Message>> get all => _messageDatasource.getAll();

  @override
  Future<List<Message>> getFrom({
    int limit = 10,
    int offset = 0,
  }) async {
    final messages = await _messageDatasource.getAll();
    return messages.skip(offset).take(limit).toList();
  }

  @override
  Future<void> save(Message message) async {
    await _messageDatasource.add(message);
  }
}
