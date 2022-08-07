import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('images/avatar.png'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text('Yashvardhan Kumar',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 10,
              color: Theme.of(context).colorScheme.primary,
            ),
            Image.asset('images/avatar.png'),
            Divider(
              height: 10,
              color: Theme.of(context).colorScheme.primary,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.thumb_up_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.comment_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
