import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/form/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String id = 'RegisterPage';

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
                  const RegisterForm(),
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