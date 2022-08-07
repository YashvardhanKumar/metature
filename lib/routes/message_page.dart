import 'package:flutter/material.dart';
import 'package:metature/components/custom_page_route.dart';
import 'package:metature/routes/chat_page.dart';
import 'package:metature/routes/feed_page.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key, required this.onBackPressed}) : super(key: key);
  final VoidCallback onBackPressed;

  static String id = 'MessagePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yashvardhan Kumar',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        leading: Consumer<HideBABFromChat>(
          builder:(context,isBAB,child) => Material(
            type: MaterialType.transparency,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: IconButton(
              onPressed: onBackPressed,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('images/avatar.png'),
            ),
            title: Text(
              'Yashvardhan Kumar',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onTap: () {
              Navigator.push(context, CustomPageRoute(child: const ChatPage()));
            },
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('images/avatar.png'),
            ),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('images/avatar.png'),
            ),
          ),
        ],
      ),
    );
  }
}
