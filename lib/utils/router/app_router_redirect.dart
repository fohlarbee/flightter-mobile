import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> appRouterRedirect(
    BuildContext context, GoRouterState state) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getString('token') != null;
  if (isLoggedIn) {
    return '/';
  }
  return '/login';
}
