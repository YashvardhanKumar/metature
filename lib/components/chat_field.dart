import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({Key? key, this.controller, required this.onChanged})
      : super(key: key);
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: TextField(
        maxLines: 5,
        minLines: 1,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: 'Message',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            border: InputBorder.none),
        // expands: true,
      ),
    );
  }
}