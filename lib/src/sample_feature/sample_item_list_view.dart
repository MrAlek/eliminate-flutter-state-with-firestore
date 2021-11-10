import 'package:flutter/material.dart';
import 'package:flutter_firestore_fun/src/bankid/bank_id_page.dart';
import 'package:flutter_firestore_fun/src/chat/chat_page.dart';
import 'package:flutter_firestore_fun/src/events/events_page.dart';
import 'sample_item.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    Key? key,
    this.items = const [
      ListItem('Trivial Chat', ChatPage.routeName),
      ListItem('Reactive BankID', BankIDPage.routeName),
      ListItem('Events editor', EventsPage.routeName),
    ],
  }) : super(key: key);

  static const routeName = '/';

  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore fun'),
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
            title: Text(item.title),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.restorablePushNamed(context, item.route);
            },
          );
        },
      ),
    );
  }
}
