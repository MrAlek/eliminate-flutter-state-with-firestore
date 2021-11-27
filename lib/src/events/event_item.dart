import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'event_editor.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.get('title')),
      subtitle: Text(DateFormat.yMMMMEEEEd().format((event.get('date') as Timestamp).toDate())),
      onTap: () => _editEvent(context, event),
    );
  }
}

Future<void> _editEvent(
  BuildContext context,
  QueryDocumentSnapshot<Map<String, dynamic>> event,
) async {
  // Create working copy in Firestore
  final workingCopy = await event.reference.collection('workingCopies').add(event.data());

  // Push editor
  final didSave = await Navigator.of(context).push(
    CupertinoModalPopupRoute(builder: (context) {
      return EventEditor(eventReference: workingCopy);
    }),
  );

  if (didSave) {
    // Update original event
    final workingCopyData = (await workingCopy.get()).data()!;
    await event.reference.update(workingCopyData);
  }

  await workingCopy.delete();
}
