import 'package:flighterr/features/authentication/screens/login/email.dart';
import 'package:flighterr/features/authentication/screens/login/password.dart';
import 'package:flighterr/features/authentication/screens/login_screen.dart';
import 'package:flighterr/features/authentication/screens/signup/birthday_screen.dart';
import 'package:flighterr/features/authentication/screens/signup/email.dart';
import 'package:flighterr/features/authentication/screens/signup/nickname_screen.dart';
import 'package:flighterr/features/authentication/screens/signup/otp_screen.dart';
import 'package:flighterr/features/authentication/screens/signup/password.dart';
import 'package:flighterr/features/authentication/screens/signup_screen.dart';
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
          path: '/otp',
          name: 'otp',
          builder: ((context, state) => OTPScreen(
                key: state.pageKey,
              )),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => SignupScreen(
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
          path: '/login-with-email',
          name: 'loginwithemail',
          builder: (context, state) => LoginWithEmail(
            key: state.pageKey,
          ),
        ),
        GoRoute(
            path: '/login-with-password',
            name: 'login-with-password',
            builder: (context, state) => LoginWithPassword(
                  key: state.pageKey,
                )),
        GoRoute(
          path: '/birthday-screen',
          name: 'birthday_screen',
          builder: (context, state) => BirthdayScreen(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: '/nickname',
          name: 'nickname',
          builder: (context, state) => NicknameScreen(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: '/register-password',
          name: 'register-password',
          builder: (context, state) => SignUpPassword(
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
