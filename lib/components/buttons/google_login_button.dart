import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/buttons/filled_button.dart';
import 'package:metature/components/clipper/hexagonal_clipper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:metature/routes/username.dart';
import 'package:provider/provider.dart';

final _auth = FirebaseAuth.instance;
final _user = FirebaseFirestore.instance.collection('users');

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: HexagonalShape(),
        child: FilledButton(
          onPressed: () async {
            setState(() => isLoggingIn = true);
            try {
              Provider.of<GoogleSignInNotifier>(context,listen: false).signIn().then(
                (value) async {
                  await _user
                      .where('emailId', isEqualTo: _auth.currentUser!.email!)
                      .get()
                      .then((value) {
                    setState(() => isLoggingIn = false);
                    final temp = (value.size == 0) ? true : false;
                    if (temp) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UsernamePage(
                              name: _auth.currentUser!.displayName!,
                              email: _auth.currentUser!.email!,
                            );
                          },
                        ),
                      );
                    } else {
                      Navigator.maybePop(context);
                    }
                  });
                },
              );
            } on FirebaseAuthException catch (e) {
              if (e.code == 'account-exists-with-different-credential') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Email already used!',
                )));
              } else {
                setState(() => isLoggingIn = false);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Check your internet connection!',
                )));
              }
            }
          },
          style: FilledButton.styleFrom(
              primary: Provider.of<ThemeDataProvider>(context).isDarkTheme
                  ? Colors.white
                  : Colors.black,
              onPrimary: Provider.of<ThemeDataProvider>(context).isDarkTheme
                  ? Colors.black
                  : Colors.white,
              shape: const RoundedRectangleBorder()),
          child: Row(
            children: [
              (isLoggingIn)
                  ? SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color:
                            Provider.of<ThemeDataProvider>(context).isDarkTheme
                                ? Colors.black
                                : Colors.white,
                      ),
                    )
                  : Image.asset(
                      'images/googlelogo.png',
                      height: 25,
                    ),
              const Expanded(
                flex: 10,
                child: Text(
                  'Login with Google',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class GoogleSignInNotifier with ChangeNotifier {
  final _googleAuth = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future signIn() async {
    final googleSignInAccount = await _googleAuth.signIn();
    if (googleSignInAccount != null) {
      _user = googleSignInAccount;
      final googleSignInAuth = await user.authentication;
      final authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken,
      );
      notifyListeners();
      return _auth.signInWithCredential(authCredential);
    }
  }

  Future logout() async {
    if(_googleAuth.currentUser != null) {
      await _googleAuth.disconnect();
    }
    _auth.signOut();
    notifyListeners();
  }
}
