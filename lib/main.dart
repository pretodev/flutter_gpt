import 'package:flutter/material.dart';
import 'package:flutter_gpt/application/load_messages.dart';
import 'package:flutter_gpt/application/send_message.dart';
import 'package:flutter_gpt/domain/chat/message_repository.dart';
import 'package:flutter_gpt/infraestructure/adapters/bot_adapter.dart';
import 'package:flutter_gpt/infraestructure/adapters/gpt/gpt_bot.dart';
import 'package:flutter_gpt/infraestructure/adapters/in_memory/message_in_memory_datasource.dart';
import 'package:flutter_gpt/infraestructure/adapters/message_datasource_adapter.dart';
import 'package:flutter_gpt/infraestructure/chat_bot_service_impl.dart';
import 'package:flutter_gpt/presentation/app.dart';
import 'package:flutter_gpt/presentation/views/chat/state/chat_controller.dart';
import 'package:flutter_gpt/presentation/views/chat/state/chat_store.dart';
import 'package:provider/provider.dart';

import 'domain/chat/chat_bot_service.dart';
import 'infraestructure/message_repository_impl.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChatStore(),
        ),
        Provider<MessageDatasourceAdapter>(
          create: (context) => MessageInMemoryDatasource(),
        ),
        Provider<BotAdapter>(
          create: (context) => GPTBot(),
        ),
        Provider<MessageRepository>(
          create: (context) => MessageRepositoryImpl(
            messageDatasource: context.read(),
          ),
        ),
        Provider<ChatBotService>(
          create: (context) => ChatBotServiceImpl(
            bot: context.read(),
          ),
        ),
        Provider(
          create: (context) => LoadMessages(
            messageRepository: context.read(),
          ),
        ),
        Provider(
          create: (context) => SendMessage(
            chatService: context.read(),
            messageRepository: context.read(),
          ),
        ),
        Provider(
          create: (context) => ChatController(
            chatStore: context.read(),
            sendMessage: context.read(),
            loadMessages: context.read(),
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
