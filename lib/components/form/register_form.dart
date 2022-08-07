import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/buttons/google_login_button.dart';
import 'package:metature/components/buttons/hexagonal_buttons.dart';
import 'package:metature/routes/username.dart';

final _auth = FirebaseAuth.instance;

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  late String email, password, name;
  bool isLoggingIn = false,
      isUsedEmail = false,
      isInvalidEmail = false,
      isWeakPassword = false;
  TextEditingController pController = TextEditingController();
  TextEditingController eController = TextEditingController();
  TextEditingController nController = TextEditingController();
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
              controller: nController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Name',
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your Name';
                }
                setState(() => name = value);
                return null;
              },
            ),
            const SizedBox(height: 16),
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
                } else if (isUsedEmail) {
                  setState(() {
                    eController.clear();
                    isUsedEmail = false;
                    isLoggingIn = false;
                  });
                  return 'This Email is Already Used!';
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
                } else if (isWeakPassword) {
                  setState(() {
                    pController.clear();
                    isUsedEmail = false;
                    isLoggingIn = false;
                  });
                  return 'Weak Password! Password should at least be 8 characters long and contain a capital letter, small letter, a special character, a number!';
                }
                setState(() => password = value);
                return null;
              },
            ),
            const SizedBox(height: 40),
            Hero(
              tag: 'register_button',
              child: FilledHexagonalButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoggingIn = true;
                      });
                      try {
                        await _auth
                            .createUserWithEmailAndPassword(
                                email: email, password: password)
                            .then((value) {
                          setState(() {
                            isLoggingIn = false;
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UsernamePage(
                                name: name,
                                email: email,
                              ),
                            ),
                          );
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-email') {
                          setState(() {
                            isLoggingIn = false;
                            isInvalidEmail = true;
                          });
                          _formKey.currentState!.validate();
                        } else if (e.code == 'email-already-in-use') {
                          setState(() {
                            isLoggingIn = false;
                            isUsedEmail = true;
                          });
                          _formKey.currentState!.validate();
                        } else if (e.code == 'weak-password') {
                          setState(() {
                            isLoggingIn = false;
                          });
                          _formKey.currentState!.validate();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No Internet!')),
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
                                'Creating',
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )
                      : const Text('Register')),
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