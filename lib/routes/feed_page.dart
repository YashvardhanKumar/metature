import 'package:flutter/material.dart';
import 'package:metature/components/bottom_navigation_routes/feed.dart';
import 'package:metature/components/bottom_navigation_routes/profile.dart';
import 'package:metature/components/bottom_navigation_routes/search.dart';
import 'package:metature/components/custom_bottom_navigation.dart';
import 'package:metature/components/bottom_navigation_routes/notification.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  static String id = 'FeedPage';

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<HideBABFromChat>(
      builder: (context,isChat,child) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: index == 1 || index == 2 || isChat.isChatPage
            ? null
            : FloatingActionButton(
                shape: CircleBorder(),
                elevation: 1,
                child: Icon(Icons.add_a_photo_rounded),
                onPressed: () {}),
        bottomNavigationBar: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: isChat.isChatPage ? 0 : 60,
              child: CustomBottomNavigation(
                  itemIcons: const [
                    Icon(Icons.home_rounded),
                    Icon(Icons.search_rounded),
                    Icon(Icons.notifications),
                    Icon(Icons.person_rounded),
                  ],
                  selectedItem: index,
                  onSelect: (int items) => setState(
                    () => (index = items),
                  ),
                ),
            ),
        body: [
          Feed(),
          Search(),
          NotificationPage(),
          Profile(),
        ][index],
      ),
    );
  }
}

class HideBABFromChat with ChangeNotifier {
  bool _isChatPage = false;

  bool get isChatPage => _isChatPage;

  togglePage(bool what) {
    _isChatPage = what;
    notifyListeners();
  }
}
