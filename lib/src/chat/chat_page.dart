import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_messages_list.dart';
import 'text_composer.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  static const routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: const [
          Expanded(
            child: ChatMessagesList(),
          ),
          SafeArea(
            child: TextComposer(),
          ),
        ],
      ),
    );
  }
}
