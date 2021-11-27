import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_item.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('chatMessages')
          .orderBy('createTime', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const CircularProgressIndicator();
        }

        final chatItems = snapshot.data!.docs;

        return ListView.builder(
          reverse: true,
          itemCount: snapshot.data?.size,
          itemBuilder: (BuildContext context, int index) {
            return ChatItem(item: chatItems[index]);
          },
        );
      },
    );
  }
}
