import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.sendEnabled,
    required this.onMessage,
  });

  final bool sendEnabled;
  final void Function(String message) onMessage;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  void _senderMessage() {
    if (widget.sendEnabled) {
      final message = textController.text;
      if (message.isNotEmpty) {
        widget.onMessage(message);
        textController.text = '';
      }
    }
    focusNode.requestFocus();
  }

  bool get isButtonEnabled =>
      textController.text.isNotEmpty && widget.sendEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        focusNode: focusNode,
        controller: textController,
        onSubmitted: (value) {
          _senderMessage();
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Pergunte...',
          suffixIcon: AnimatedBuilder(
            animation: textController,
            builder: (context, _) {
              return IconButton(
                onPressed: !isButtonEnabled ? null : _senderMessage,
                icon: const Icon(Icons.send),
              );
            },
          ),
        ),
      ),
    );
  }
}
