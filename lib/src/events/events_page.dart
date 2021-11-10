import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_fun/src/events/event_editor.dart';
import 'package:intl/intl.dart';

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
            itemBuilder: (BuildContext context, int index) {
              final event = chatItems[index];

              return ListTile(
                title: Text(event.get('title')),
                subtitle:
                    Text(DateFormat.yMMMMEEEEd().format((event.get('date') as Timestamp).toDate())),
                onTap: () async {
                  final workingCopy = await _createWorkingCopy(event);

                  final didSave = await Navigator.of(context).push(
                    CupertinoModalPopupRoute(builder: (context) {
                      return EventEditor(eventReference: workingCopy);
                    }),
                  );

                  if (didSave) {
                    final workingCopyData = (await workingCopy.get()).data();
                    if (workingCopyData != null) {
                      await event.reference.update(workingCopyData);
                    }
                  }
                  await workingCopy.delete();
                },
              );
            },
          );
        },
      ),
    );
  }
}

Future<DocumentReference<Map<String, dynamic>>> _createWorkingCopy(
    QueryDocumentSnapshot<Map<String, dynamic>> event) {
  return event.reference.collection('workingCopies').add(event.data());
}
