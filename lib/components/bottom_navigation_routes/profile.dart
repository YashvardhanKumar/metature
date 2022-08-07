import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/buttons/google_login_button.dart';
import 'package:metature/components/buttons/hexagonal_buttons.dart';
import 'package:provider/provider.dart';

var _auth = FirebaseAuth.instance;
final _user = FirebaseFirestore.instance.collection('users');

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _user.doc(_auth.currentUser!.email).snapshots(),
        builder: (context, snapshot) {
          String username = 'Metature User';
          String name = 'User';
          if(snapshot.hasData) {
            final userData = snapshot.data!;
            username = userData.get('username');
            name = userData.get('name');
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                username,
                style: const TextStyle(
                    fontFamily: 'Cabin Sketch',
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              actions: const [
                Hero(
                  tag: 'dark_mode_toggle',
                  child: DarkModeToggler(),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('images/avatar.png'),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          elevation: 3,
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkResponse(
                            onTap: () {},
                            child: Column(
                              children: const [
                                Text('10'),
                                Text('Posts'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          clipBehavior: Clip.hardEdge,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkResponse(
                            onTap: () {},
                            child: Column(
                              children: const [
                                Text('10.2K'),
                                Text('Friends'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          name,
                          // textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: FilledTonalHexagonalButton(
                          onPressed: () => setState(() {}),
                          child: const Text('Edit Profile'),
                        ),
                      ),
                      Center(
                        child: FilledHexagonalButton(
                          onPressed: () async {
                            Provider.of<GoogleSignInNotifier>(context,listen: false).logout();
                          },
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

          );
        });
  }
}
