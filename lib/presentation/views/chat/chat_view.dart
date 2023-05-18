import 'package:flutter/material.dart';
import 'package:flutter_gpt/presentation/views/chat/state/chat_controller.dart';
import 'package:flutter_gpt/presentation/views/chat/state/chat_store.dart';
import 'package:flutter_gpt/presentation/views/chat/widgets/chat_bubble.dart';
import 'package:flutter_gpt/presentation/views/chat/widgets/chat_input.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final controller = context.read<ChatController>();

  @override
  void initState() {
    super.initState();
    controller.loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<ChatStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter GPT'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 80.0),
            itemCount: store.messages.length,
            reverse: true,
            itemBuilder: (context, index) {
              return ChatBubble(
                message: store.messages[index],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ChatInput(
              sendEnabled: !store.isLoading,
              onMessage: controller.sendMessage,
            ),
          )
        ],
      ),
    );
  }
}
