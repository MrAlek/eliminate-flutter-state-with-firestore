import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventEditor extends StatelessWidget {
  const EventEditor({Key? key, required this.eventReference}) : super(key: key);

  final DocumentReference<Map<String, dynamic>> eventReference;

  static const routeName = '/events';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit event'),
        leadingWidth: 80,
        leading: TextButton(
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        actions: [
          TextButton(
            child: const Text('Save', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: eventReference.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CupertinoActivityIndicator();
          }
          if (!snapshot.data!.exists) {
            return const SizedBox();
          }

          final event = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: event.get('title'),
                  onFieldSubmitted: (title) {
                    eventReference.update({'title': title});
                  },
                ),
                InputDatePickerFormField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 1000)),
                  initialDate: (event.get('date') as Timestamp).toDate(),
                  onDateSubmitted: (date) {
                    eventReference.update({'date': Timestamp.fromDate(date)});
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
