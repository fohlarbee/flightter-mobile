import 'package:flighterr/features/authentication/screens/login_screen.dart';
import 'package:flighterr/features/authentication/screens/signup/birthday_screen.dart';
import 'package:flighterr/features/authentication/screens/signup/email.dart';
import 'package:flighterr/features/dashboard/screens/dashboard.dart';
import 'package:flighterr/features/dashboard/screens/home_screen.dart';
import 'package:flighterr/features/dashboard/screens/profile_screen.dart';
import 'package:flighterr/utils/router/go_router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  //final firstLaunchAsyncValue = ref.read(firstLaunchNotifierProvider);
  final notifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
      navigatorKey: _rootNavigator,
      initialLocation: '/signupwithemail',
      refreshListenable: notifier,
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => LoginScreen(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: '/signupwithemail',
          name: 'signupemail',
          builder: (context, state) => SignUpWithEmail(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: '/birthday-screen',
          name: 'birthday_screen',
          builder: (context, state) => BirthdayScreen(
            key: state.pageKey,
          ),
        ),
        ShellRoute(
            navigatorKey: _shellNavigator,
            builder: (context, state, child) => DashboardScreen(
                  key: state.pageKey,
                  child: child,
                ),
            routes: [
              GoRoute(
                  path: '/',
                  name: 'home',
                  builder: (context, state) => HomeScreen(
                        key: state.pageKey,
                      )),
              GoRoute(
                  path: '/profile',
                  name: 'profile',
                  builder: (context, state) => ProfileScreen(
                        key: state.pageKey,
                      )),
            ])
      ]);
});
