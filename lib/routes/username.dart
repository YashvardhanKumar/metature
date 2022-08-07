import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/form/username_form.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({
    Key? key,
    required this.email,
    required this.name,
  }) : super(key: key);
  final String email, name;
  static String id = 'UsernamePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              UsernameForm(
                name: name,
                email: email,
              ),
              const Hero(
                tag: 'dark_mode_toggle',
                child: DarkModeToggler(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
