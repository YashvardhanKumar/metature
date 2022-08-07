import 'package:flutter/material.dart';

class StoryButton extends StatelessWidget {
  const StoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/avatar.png'),
          ),
          Text(
            'Your Story',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          )
        ],
      ),
    );
  }
}