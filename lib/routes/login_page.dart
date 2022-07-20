import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/buttons/filled_button.dart';
import 'package:metature/components/clipper/hexagonal_clipper.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              const LoginForm(),
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

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Email',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter your Email ID';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
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
                  }
                  return null;
                },
              ),
            ),
            Hero(
              tag: 'login_button',
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(top: 40),
                child: ClipPath(
                  clipper: HexagonalShape(),
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: LinearProgressIndicator()),
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                        shape: const RoundedRectangleBorder()),
                    child: const Text('Login'),
                  ),
                ),
              ),
            ),
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
            ClipPath(
              clipper: HexagonalShape(),
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                    primary: Provider.of<ThemeDataProvider>(context).isDarkTheme
                        ? Colors.white
                        : Colors.black,
                    onPrimary:
                        Provider.of<ThemeDataProvider>(context).isDarkTheme
                            ? Colors.black
                            : Colors.white,
                    shape: const RoundedRectangleBorder()),
                child: Row(
                  children: [
                    Image.asset(
                      'images/googlelogo.png',
                      height: 25,
                    ),
                    const Expanded(
                        flex: 10,
                        child: Text(
                          'Login with Google',
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
            ),
            ClipPath(
              clipper: HexagonalShape(),
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                    primary: const Color(0xff1877f2),
                    onPrimary: Colors.white,
                    shape: const RoundedRectangleBorder()),
                child: Row(
                  children: [
                    Image.asset(
                      'images/facebooklogo.png',
                      height: 25,
                    ),
                    const Expanded(
                        flex: 10,
                        child: Text(
                          'Continue with Facebook',
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
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
