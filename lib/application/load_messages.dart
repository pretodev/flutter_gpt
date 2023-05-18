import 'package:flutter_gpt/domain/chat/message_repository.dart';

import '../domain/chat/message.dart';

class LoadMessages {
  final MessageRepository _messageRepository;

  LoadMessages({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  Future<List<Message>> call({int page = 1}) async {
    return _messageRepository.getFrom(
      limit: 10,
      offset: (page - 1) * 10,
    );
  }
}
