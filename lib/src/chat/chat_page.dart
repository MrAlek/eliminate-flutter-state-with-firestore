import 'package:cloud_firestore/cloud_firestore.dart';
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
            child: TextComposer(
              onSubmitted: _sendNewMessage,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _sendNewMessage(String? text) async {
  await FirebaseFirestore.instance.collection('chatMessages').add({
    'body': text,
    'createTime': FieldValue.serverTimestamp(),
    'sender': 'me',
  });
}
