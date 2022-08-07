import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/buttons/hexagonal_buttons.dart';

class ExternalProfilePage extends StatefulWidget {
  const ExternalProfilePage({
    Key? key,
    required this.userDetails,
  }) : super(key: key);
  final QueryDocumentSnapshot userDetails;
  static String id = 'ExternalProfilePage';
  @override
  State<ExternalProfilePage> createState() => _ExternalProfilePageState();
}

class _ExternalProfilePageState extends State<ExternalProfilePage> {
  bool followClicked = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width-24;
    final width1 = (width) / 2;
    final width2 = (width) / 2;
    final String name = widget.userDetails['name'];
    final String username = widget.userDetails['username'];
    final List friends = widget.userDetails['friends'];

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
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('${friends.length}'),
                          const Text('Posts'),
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
                    child: InkWell(
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
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.ease,
                        width: (followClicked) ? width1 : 0,
                        child: FilledTonalHexagonalButton(
                          onPressed: () =>
                              setState(() => followClicked = false),
                          child: Text(
                            'Unfriend',
                            style: TextStyle(
                              fontSize: (followClicked) ? null : 0,
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.ease,
                        width: (followClicked) ? width2 : width,
                        child: FilledHexagonalButton(
                          onPressed: () => (followClicked)
                              ? setState(() {})
                              : setState(() => followClicked = true),
                          child: (followClicked)
                              ? const Text('Message')
                              : const Text('Add Friend'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    //   Scaffold(
    //     appBar: AppBar(
    //       title: Text(
    //         username,
    //         style: const TextStyle(
    //             fontFamily: 'Cabin Sketch',
    //             fontWeight: FontWeight.w700,
    //             fontSize: 20),
    //       ),
    //       actions: const [
    //         Hero(
    //           tag: 'dark_mode_toggle',
    //           child: DarkModeToggler(),
    //         ),
    //       ],
    //     ),
    //     body: Padding(
    //       padding: const EdgeInsets.all(20.0),
    //       child: Column(
    //         children: [
    //           Row(
    //             children: [
    //               const CircleAvatar(
    //                 radius: 30,
    //                 backgroundImage: AssetImage('images/avatar.png'),
    //               ),
    //               Expanded(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.stretch,
    //                     children: [
    //                       Padding(
    //                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                         child: Text(
    //                           name,
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 45,
    //                         child: Row(
    //                           children: [
    //                             AnimatedContainer(
    //                               duration: const Duration(milliseconds: 100),
    //                               curve: Curves.ease,
    //                               width: (followClicked) ? width1 : 0,
    //                               child: FilledTonalHexagonalButton(
    //                                 onPressed: () =>
    //                                     setState(() => followClicked = false),
    //                                 child: Text(
    //                                   'Friends',
    //                                   style: TextStyle(
    //                                     fontSize: (followClicked) ? null : 0,),
    //                                 ),
    //                               ),
    //                             ),
    //                             AnimatedContainer(
    //                               duration: const Duration(milliseconds: 100),
    //                               curve: Curves.ease,
    //                               width: (followClicked) ? width2 : width,
    //                               child: FilledHexagonalButton(
    //                                 onPressed: () => (followClicked)
    //                                     ? setState(() {})
    //                                     : setState(() => followClicked = true),
    //                                 child: (followClicked)
    //                                     ? const Text('Message')
    //                                     : const Text('Add Friend'),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ],
    //       ),
    //     )
    // );
  }
}
