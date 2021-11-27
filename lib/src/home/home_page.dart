import 'package:flutter/material.dart';
import 'package:flutter_firestore_fun/src/bankid/bank_id_page.dart';
import 'package:flutter_firestore_fun/src/chat/chat_page.dart';
import 'package:flutter_firestore_fun/src/events/events_page.dart';
import 'home_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    this.items = const [
      HomeItem('Trivial Chat', ChatPage.routeName),
      HomeItem('Reactive BankID', BankIDPage.routeName),
      HomeItem('Events editor', EventsPage.routeName),
    ],
  }) : super(key: key);

  static const routeName = '/';

  final List<HomeItem> items;

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
