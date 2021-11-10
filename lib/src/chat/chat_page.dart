import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('chatMessages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return const CupertinoActivityIndicator();
                }
                final chatItems = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data?.size,
                  itemBuilder: (BuildContext context, int index) {
                    final item = chatItems[index];

                    return ListTile(
                      title: Text(
                        item.get('body'),
                        textAlign: item.get('sender') == 'me' ? TextAlign.end : TextAlign.start,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SafeArea(
            child: Composer(),
          ),
        ],
      ),
    );
  }
}

class Composer extends StatefulWidget {
  const Composer({Key? key}) : super(key: key);

  @override
  _ComposerState createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: TextField(
        controller: _textController,
        autofocus: true,
        textInputAction: TextInputAction.send,
        onSubmitted: (text) {
          _sendNewMessage(text);
          _textController.clear();
        },
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

void _sendNewMessage(String text) {
  FirebaseFirestore.instance.collection('chatMessages').add({
    'body': text,
    'createdTime': FieldValue.serverTimestamp(),
    'sender': 'me',
  });
}
