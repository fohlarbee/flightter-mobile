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
      initialLocation: '/',
      refreshListenable: notifier,
      routes: [
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
