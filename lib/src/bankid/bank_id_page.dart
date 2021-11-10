import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BankIDPage extends StatelessWidget {
  const BankIDPage({Key? key}) : super(key: key);

  static const routeName = '/bankid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BankID payment'),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.doc('bankIDSessions/1').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.data?.get('status')) {
              case null:
              case 'loading':
                return const _Loading();
              case 'ready':
                return const _Ready();
              case 'waitingForBankID':
                return const _WaitingForBankID();
              case 'error':
                return const _Error();
              case 'finished':
                return const _Finished();
            }
            throw ('Unknown status');
          },
        ),
      ),
    );
  }
}

class _Ready extends StatelessWidget {
  const _Ready({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Amount to pay: 100 kr', style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(height: 10),
        const OutlinedButton(
          child: Text('Pay with BankID'),
          onPressed: _pay,
        ),
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CupertinoActivityIndicator(),
        const SizedBox(height: 10),
        Text('Loading', style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}

class _WaitingForBankID extends StatelessWidget {
  const _WaitingForBankID({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CupertinoActivityIndicator(),
        const SizedBox(height: 10),
        Text('Waiting for BankID', style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(height: 10),
        OutlinedButton(
          child: const Text('Open BankID App'),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
        const SizedBox(height: 10),
        Text('Something went wrong!', style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(height: 10),
        const OutlinedButton(
          child: Text('Try again'),
          onPressed: _pay,
        ),
      ],
    );
  }
}

class _Finished extends StatelessWidget {
  const _Finished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('🎉', style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: 10),
        Text('Payment complete!', style: Theme.of(context).textTheme.headline5),
      ],
    );
  }
}

_pay() {
  FirebaseFirestore.instance.doc('bankIDSessions/1').update({'status': 'loading'});
}
