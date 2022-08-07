import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/buttons/hexagonal_buttons.dart';

final _auth = FirebaseAuth.instance;
final _user = FirebaseFirestore.instance.collection('users');

class UsernameForm extends StatefulWidget {
  const UsernameForm({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  final String name, email;

  @override
  State<UsernameForm> createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {
  final _formKey = GlobalKey<FormState>();
  bool usernameAvailable = true;
  late String username;
  TextEditingController unController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              controller: unController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Username',
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your username';
                } else if (!usernameAvailable) {
                  setState(() => usernameAvailable = true);
                  return 'Username Already taken';
                }
                setState(() {
                  username = value;
                });
                return null;
              },
            ),
            Hero(
              tag: 'register_button',
              child: FilledHexagonalButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final bool temp = await _user
                          .where('username', isEqualTo: username)
                          .get()
                          .then((value) => (value.size == 0) ? true : false);
                      setState(() {
                        usernameAvailable = temp;
                      });
                      if (_formKey.currentState!.validate()) {
                        await _user.doc(_auth.currentUser!.email).set({
                          'username': username.trim(),
                          'emailId': _auth.currentUser!.email,
                          'name': widget.name.trim(),
                          'friends': [],
                          'blocked': [],
                        }).then((value) {
                          Navigator.maybePop(context);
                        });
                      }
                    }
                  },
                  child: const Text('Set Username')),
            ),
            Divider(
              height: 10,
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
