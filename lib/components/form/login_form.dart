import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/buttons/google_login_button.dart';
import 'package:metature/components/buttons/hexagonal_buttons.dart';

final _auth = FirebaseAuth.instance;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  late String email, password;
  bool isLoggingIn = false, isIncorrectPassword = false, isInvalidEmail = false;
  TextEditingController pController = TextEditingController();
  TextEditingController eController = TextEditingController();

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
              keyboardType: TextInputType.emailAddress,
              controller: eController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Email',
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your Email ID';
                } else if (isInvalidEmail) {
                  setState(() {
                    eController.clear();
                    isInvalidEmail = false;
                    isLoggingIn = false;
                  });
                  return 'Invalid Email ID';
                }
                setState(() => email = value);
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: pController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !isVisible,
              decoration: InputDecoration(
                filled: true,
                suffixIcon: IconButton(
                  splashRadius: 20,
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                ),
                hintText: 'Enter Your Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your Password';
                } else if (isIncorrectPassword) {
                  setState(() {
                    pController.clear();
                    isIncorrectPassword = false;
                    isLoggingIn = false;
                  });
                  return 'Incorrect Password';
                }
                setState(() => password = value);
                return null;
              },
            ),
            const SizedBox(height: 40),
            Hero(
              tag: 'login_button',
              child: FilledHexagonalButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoggingIn = true;
                    });
                    try {
                      await _auth
                          .signInWithEmailAndPassword(
                              email: email.trim(), password: password.trim())
                          .then((value) {
                        Navigator.maybePop(context);
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-email') {
                        setState(() {
                          isLoggingIn = false;
                          isInvalidEmail = true;
                        });
                        _formKey.currentState!.validate();
                      } else if (e.code == 'wrong-password') {
                        setState(() {
                          isLoggingIn = false;
                          isIncorrectPassword = true;
                        });
                        _formKey.currentState!.validate();
                      } else if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User Not Found')),
                        );
                        setState(() {
                          isLoggingIn = false;
                        });
                      }
                    }
                  }
                },
                child: isLoggingIn
                    ? Row(
                        children: [
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Logging In',
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    : const Text('Login'),
              ),
            ),
            CupertinoButton(
                child: const Text('Forgot Password?'), onPressed: () {}),
            const SizedBox(height: 20),
            Divider(
              height: 10,
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const Text(
              'Or',
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 10,
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const GoogleLoginButton(),
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
