import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'event_item.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  static const routeName = '/events';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const CupertinoActivityIndicator();
          }

          final chatItems = snapshot.data!.docs;
          return ListView.builder(
            itemCount: snapshot.data?.size,
            itemBuilder: (BuildContext context, int index) => EventItem(event: chatItems[index]),
          );
        },
      ),
    );
  }
}
