import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/buttons/hexagonal_buttons.dart';
import 'package:metature/firebase_options.dart';
import 'package:metature/routes/login_page.dart';
import 'package:metature/theme_data.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider<ThemeDataProvider>(
      create: (_) => ThemeDataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: MetatureTheme.lightMode,
        darkTheme: MetatureTheme.darkMode,
        themeMode: Provider.of<ThemeDataProvider>(context).isDarkTheme
            ? ThemeMode.dark
            : ThemeMode.light,
        title: 'Flutter Demo',
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Hero(
              tag: 'dark_mode_toggle',
              child: DarkModeToggler(),
            ),
            Column(
              children: [
                Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.asset('images/logo.png'),
                    )),
                Text(
                  'Connecting Nature!',
                  style: TextStyle(
                      fontFamily: 'Cabin Sketch',
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Hero(
                    tag: 'login_button',
                    child: FilledHexagonalButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginPage())),
                      child: const Text('Login'),
                    ),
                  ),
                ),
                Expanded(
                  child: FilledTonalHexagonalButton(
                    onPressed: () {},
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
