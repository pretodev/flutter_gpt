import 'package:chat_gpt_flutter/chat_gpt_flutter.dart' as gpt;
import 'package:flutter_gpt/infraestructure/adapters/bot_adapter.dart';

import '../../../domain/chat/message.dart';
import '../../../domain/chat/sender_type.dart';

class GPTBot implements BotAdapter {
  final _chatGpt = gpt.ChatGpt(
    apiKey: const String.fromEnvironment("GPT_API_KEY"),
  );

  @override
  Stream<Message> requestResponse(List<Message> context) async* {
    final gptMessages = context
        .map((m) => gpt.Message(
              content: m.content,
              role: m.senderType == SenderType.bot
                  ? gpt.Role.assistant.name
                  : gpt.Role.user.name,
            ))
        .toList();
    final request = gpt.CompletionRequest(
      messages: gptMessages,
      maxTokens: 4000,
      model: gpt.ChatGptModel.gpt35Turbo,
      stream: true,
    );
    final stream = await _chatGpt.createChatCompletionStream(request);
    if (stream == null) {
      return;
    }
    var message = Message(
      senderType: SenderType.bot,
      content: '',
    );

    yield* stream.map((event) {
      final buffedMessage = event.choices?.first.delta?.content ?? '';
      message = message.copyWith(
        content: '${message.content}$buffedMessage',
        completed: event.streamMessageEnd,
      );
      return message;
    });
  }
}
