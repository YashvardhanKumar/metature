import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/buttons/hexagonal_buttons.dart';
import 'package:metature/routes/feed_page.dart';
import 'package:provider/provider.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);
  static String id = 'VerifyPage';

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController verController = TextEditingController();
  late String email;
  bool canResendEmail = false;
  bool enteredEmail = false;
  bool verifiedEmail = false;
  Timer? timer;

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.code),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    verifiedEmail = _auth.currentUser!.emailVerified;
    if (!verifiedEmail) {
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        await _auth.currentUser!.reload();
        setState(() => verifiedEmail = _auth.currentUser!.emailVerified);
      });
      if (verifiedEmail) timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return verifiedEmail
        ? ChangeNotifierProvider<HideBABFromChat>(
            create: (context) => HideBABFromChat(),
            builder: (context, child) => const FeedPage(),
          )
        : Scaffold(
            body: SafeArea(
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Check your email ID, click on the Link to verify!. Make sure you check your spam folder too!',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    FilledHexagonalButton(
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      child: const Text('Send Verification Email'),
                    ),
                    FilledTonalHexagonalButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Warning!'),
                            content: const Text(
                              'Are you sure you want to cancel? It will delete your account for security reasons! You can create your account again',
                            ),
                            actions: [
                              FilledHexagonalButton(
                                  child: const Text('Yes'),
                                  onPressed: () async {
                                    try {
                                      final user = _auth.currentUser!.email;
                                      await _auth.currentUser!.delete();
                                      await _firestore
                                          .collection('users')
                                          .where('emailId', isEqualTo: user)
                                          .get()
                                          .then(
                                            (value) async => await _firestore
                                                .collection('users')
                                                .doc(
                                                  value.docs.first
                                                      .get('username'),
                                                )
                                                .delete()
                                                .then(
                                                  (value) =>
                                                      Navigator.pop(context),
                                                ),
                                          );
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'requires-recent-login') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Session Expired')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('No Internet!')),
                                        );
                                      }
                                    }
                                  }),
                              FilledTonalHexagonalButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
