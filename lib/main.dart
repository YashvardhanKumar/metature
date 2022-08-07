import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:metature/components/buttons/dark_mode_toggler.dart';
import 'package:metature/components/buttons/google_login_button.dart';
import 'package:metature/components/buttons/hexagonal_buttons.dart';
import 'package:metature/firebase_options.dart';
import 'package:metature/routes/login_page.dart';
import 'package:metature/routes/register_page.dart';
import 'package:metature/routes/verify_page.dart';
import 'package:metature/theme_data.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeDataProvider>(
          create: (_) => ThemeDataProvider(),
        ),
        ChangeNotifierProvider<GoogleSignInNotifier>(
          create: (context) => GoogleSignInNotifier(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
            PointerDeviceKind.invertedStylus,
            PointerDeviceKind.trackpad,
          },
        ),
        theme: MetatureTheme.lightMode,
        darkTheme: MetatureTheme.darkMode,
        themeMode: Provider.of<ThemeDataProvider>(context).isDarkTheme
            ? ThemeMode.dark
            : ThemeMode.light,
        title: 'Metature',
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const VerifyEmail();
              }
              return const HomePage();
            }));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Hero(
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
                          MaterialPageRoute(builder: (_) => const LoginPage())),
                      child: const Text('Login'),
                    ),
                  ),
                ),
                Expanded(
                  child: Hero(
                    tag: 'register_button',
                    child: FilledTonalHexagonalButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RegisterPage())),
                      child: const Text('Register'),
                    ),
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
