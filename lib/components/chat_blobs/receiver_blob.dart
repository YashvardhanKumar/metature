import 'package:flutter/material.dart';

class ChatBlobReceiver extends StatelessWidget {
  const ChatBlobReceiver({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 100,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}