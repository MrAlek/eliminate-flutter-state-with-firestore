import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  final Function(String?) onSubmitted;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
        child: TextField(
          controller: _textController,
          textCapitalization: TextCapitalization.sentences,
          autofocus: true,
          textInputAction: TextInputAction.send,
          onSubmitted: (text) {
            widget.onSubmitted(text);
            _textController.clear();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
