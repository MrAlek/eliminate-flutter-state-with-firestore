import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firestore_fun/src/bankid/bank_id_page.dart';
import 'package:flutter_firestore_fun/src/chat/chat_page.dart';
import 'package:flutter_firestore_fun/src/events/events_page.dart';

import 'home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Fun',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xFFf7cb51),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case ChatPage.routeName:
                return const ChatPage();
              case BankIDPage.routeName:
                return const BankIDPage();
              case EventsPage.routeName:
                return const EventsPage();
              case HomePage.routeName:
              default:
                return const HomePage();
            }
          },
        );
      },
    );
  }
}
