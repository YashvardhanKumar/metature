import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataProvider with ChangeNotifier {
  bool _useDarkTheme = ThemeMode.system == ThemeMode.dark;
  SharedPreferences? _prefs;

  ThemeDataProvider() {
    _loadPrefs();
  }

  bool get isDarkTheme => _useDarkTheme;

  void toggleTheme() {
    _useDarkTheme = !_useDarkTheme;
    _savePrefs();
    notifyListeners();
  }

//The reset is just incase you want to save the selected theme for the next time your app is run.
  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadPrefs() async {
    await _initPrefs();
    _useDarkTheme = _prefs?.getBool("useDarkMode") ?? true;
    notifyListeners();
  }

  _savePrefs() async {
    await _initPrefs();
    await _prefs?.setBool("useDarkMode", _useDarkTheme);
  }
}

class DarkModeToggler extends StatelessWidget {
  const DarkModeToggler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
          onPressed: Provider.of<ThemeDataProvider>(context).toggleTheme,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, anim) => RotationTransition(
              turns: const ValueKey('dark') == child.key
                  ? Tween<double>(begin: 0.75, end: 1).animate(anim)
                  : Tween<double>(begin: 1.25, end: 1).animate(anim),
              child: ScaleTransition(
                scale: anim,
                child: child,
              ),
            ),
            child: Provider.of<ThemeDataProvider>(context).isDarkTheme
                ? Icon(
                    Icons.light_mode_rounded,
                    key: const ValueKey('light'),
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(
                    Icons.dark_mode_rounded,
                    key: const ValueKey('dark'),
                    color: Theme.of(context).colorScheme.primary,
                  ),
          ),
        ),
    );
  }
}
