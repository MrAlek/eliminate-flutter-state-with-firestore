import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.get('body'),
        textAlign: item.get('sender') == 'me' ? TextAlign.end : TextAlign.start,
      ),
    );
  }
}
