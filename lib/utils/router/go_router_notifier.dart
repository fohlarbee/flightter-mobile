import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final goRouterNotifierProvider = Provider<GoRouterNotifier>((ref) {
  return GoRouterNotifier();
});

final firstLaunchNotifierProvider = FutureProvider<bool>((ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('first_launch') ?? true;
  if (isFirstLaunch) {
    prefs.setBool('first_launch', false);
  }
  return isFirstLaunch;
});

Future<String?> appRouterRedirect(
    BuildContext context, GoRouterState state) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getString('token') != null;
  if (isLoggedIn) {
    return '/';
  }
  return '/login';
}

class GoRouterNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  //UI Provider
  bool _isDark = false;
  bool get isDark => _isDark;

  final lightTheme = ThemeData(
    primaryColor: const Color(0xFF001F3F),
    brightness: Brightness.light,
    primaryColorDark: const Color(0xFF001F3F),
  );

  final darkTheme = ThemeData(
    primaryColor: const Color(0xFF001F3F),
    brightness: Brightness.dark,
    primaryColorDark: const Color(0xFF001F3F),
  );

  changeTheme() {
    _isDark = !isDark;
    notifyListeners();
  }
}
