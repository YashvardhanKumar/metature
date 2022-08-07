import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/chat_blobs/receiver_blob.dart';
import 'package:metature/components/chat_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static String id = 'ChatPage';
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();
  String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Material(
          type: MaterialType.transparency,
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        title: const Text('XYZ'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return const ChatBlobReceiver();
                },
                // crossAxisAlignment:,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Theme.of(context).colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              // margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                        child: ChatTextField(
                      onChanged: (val) {
                        setState(() {
                          text = val;
                        });
                      },
                      controller: controller,
                    )),
                    if (text != null && text != '')
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: Icon(
                          Icons.send_rounded,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}