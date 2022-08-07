import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/buttons/hexagonal_buttons.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metature', style: TextStyle(fontFamily: 'Cabin Sketch', fontWeight: FontWeight.w700, fontSize: 30),),
        actions: [
          const Hero(
            tag: 'dark_mode_toggle',
            child: DarkModeToggler(),
          ),
        ],
      ),
      body: Center(
        child: FilledHexagonalButton(
          onPressed: () {},
          child: Text('Yes'),
        ),
      ),
    );
  }
}
