import 'package:flutter/material.dart';
import 'package:flutter_gpt/presentation/views/chat/chat_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GPT',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ChatView(),
    );
  }
}
