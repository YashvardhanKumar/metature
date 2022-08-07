import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/custom_search_delegate.dart';

final _users = FirebaseFirestore.instance.collection('users');

class Search extends StatefulWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Card(
            margin: EdgeInsets.all(5),
            clipBehavior: Clip.hardEdge,
            child: StreamBuilder<QuerySnapshot>(
              stream: _users.snapshots(),
              builder: (context, snapshot) {
                List<SearchSuggestionsTileData> tileListData = [];
                if (snapshot.hasData) {
                  final accounts = snapshot.data!.docs;
                  for (var account in accounts) {
                    final name = account['name'];
                    final username = account['username'];
                    tileListData.add(SearchSuggestionsTileData(name: name, username: username));
                  }
                }
                return InkWell(
                  onTap: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate(listTileData: tileListData,snapshot: snapshot));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.search_rounded),
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              CupertinoButton(
                onPressed: () {},
                child: Image.asset('images/avatar.png'),
              ),
              CupertinoButton(
                onPressed: () {},
                child: Image.asset('images/avatar.png'),
              ),
              CupertinoButton(
                onPressed: () {},
                child: Image.asset('images/avatar.png'),
              ),
              CupertinoButton(
                onPressed: () {},
                child: Image.asset('images/avatar.png'),
              ),
              CupertinoButton(
                onPressed: () {},
                child: Image.asset('images/avatar.png'),
              ),
              CupertinoButton(
                onPressed: () {},
                child: Image.asset('images/avatar.png'),
              ),
            ],
          ),
        ));
  }
}

class SearchSuggestionsTileData {
  final String name;
  final String username;
  SearchSuggestionsTileData({required this.name, required this.username});
}