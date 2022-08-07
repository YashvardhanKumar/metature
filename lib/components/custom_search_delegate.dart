import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/bottom_navigation_routes/search.dart';
import 'package:metature/components/custom_page_route.dart';
import 'package:metature/routes/external_profile_profile.dart';

final _auth = FirebaseAuth.instance;

class CustomSearchDelegate extends SearchDelegate {
  final List<SearchSuggestionsTileData> listTileData;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  CustomSearchDelegate({required this.snapshot, required this.listTileData});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query != '')
        Material(
          type: MaterialType.transparency,
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: IconButton(
            onPressed: () {
              query = '';
            },
            icon: const Icon(Icons.clear_rounded),
          ),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_rounded),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ListTile> tiles = [];
    if (snapshot.hasData) {
      final dat = snapshot.data!.docs;
      for (int i = 0; i < listTileData.length; i++) {
        if (dat[i].id != _auth.currentUser!.email &&
            (listTileData[i]
                    .username
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                listTileData[i]
                    .name
                    .toLowerCase()
                    .contains(query.toLowerCase()))) {
          tiles.add(
            ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/avatar.png'),
              ),
              title: Text(listTileData[i].username),
              subtitle: Text(
                listTileData[i].name,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRoute(
                    child: ExternalProfilePage(
                      userDetails: dat[i],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }
    }
    return ListView.builder(
      itemCount: tiles.length,
      itemBuilder: (context, index) {
        return tiles[index];
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ListTile> tiles = [];
    if (snapshot.hasData) {
      for (int i = 0; i < listTileData.length; i++) {
        final dat = snapshot.data!.docs;
        if (dat[i].id != _auth.currentUser!.email &&
            (listTileData[i]
                    .username
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                listTileData[i]
                    .name
                    .toLowerCase()
                    .contains(query.toLowerCase()))) {
          tiles.add(
            ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/avatar.png'),
              ),
              title: Text(listTileData[i].username),
              subtitle: Text(
                listTileData[i].name,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRoute(
                    child: ExternalProfilePage(
                      userDetails: snapshot.data!.docs[i],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }
    }
    return (query != '')
        ? ListView.builder(
            itemCount: tiles.length,
            itemBuilder: (context, index) {
              return tiles[index];
            },
          )
        : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).colorScheme.primary.withAlpha(100),
                ),
                Text(
                  'Search users',
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(100)),
                )
              ],
            ),
          );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 18,
          color: Theme.of(context).colorScheme.primary.withAlpha(100),
        ),
        counterStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
