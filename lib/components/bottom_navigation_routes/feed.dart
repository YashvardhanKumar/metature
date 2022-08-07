import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/post_card.dart';
import 'package:metature/components/story_circle_button.dart';
import 'package:metature/routes/feed_page.dart';
import 'package:metature/routes/message_page.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
  }) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Consumer<HideBABFromChat>(
      builder: (context, isChat, child) => WillPopScope(
        onWillPop: () async {
          if (controller.page == 0) {
            return true;
          } else {
            setState(() {
              controller.previousPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              );
              isChat.togglePage(false);
            });
            return false;
          }
        },
        child: PageView(
          controller: controller,
          onPageChanged: (page) {
            if (page == 0) {
              isChat.togglePage(false);
            } else {
              isChat.togglePage(true);
            }
          },
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Metature',
                  style: TextStyle(
                    fontFamily: 'Cabin Sketch',
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
                actions: [
                  const Hero(
                    tag: 'dark_mode_toggle',
                    child: DarkModeToggler(),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          controller.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease,
                          );
                          isChat.togglePage(true);
                        });
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => MessagePage()));
                      },
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: const [
                          StoryButton(),
                          StoryButton(),
                          StoryButton(),
                          StoryButton(),
                        ],
                      ),
                    ),
                    Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            children: const [
                              PostCard(),
                              PostCard(),
                              PostCard(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MessagePage(
              onBackPressed: () {
                setState(() {
                  controller.previousPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                  isChat.togglePage(false);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

