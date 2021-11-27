import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({Key? key}) : super(key: key);

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
        child: TextField(
          controller: _textController,
          autofocus: true,
          textInputAction: TextInputAction.send,
          onSubmitted: (text) {
            _sendNewMessage(text);
            _textController.clear();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

Future<void> _sendNewMessage(String text) async {
  await FirebaseFirestore.instance.collection('chatMessages').add({
    'body': text,
    'createTime': FieldValue.serverTimestamp(),
    'sender': 'me',
  });
}
