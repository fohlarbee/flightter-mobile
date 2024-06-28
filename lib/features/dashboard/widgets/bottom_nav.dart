import 'package:flighterr/features/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final position = ref.watch(dashboardControllerProvider);

    return BottomNavigationBar(
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        elevation: 1,
        currentIndex: position,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Feather.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Feather.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.albums_outline), label: 'Library'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.person_outline), label: 'Profile'),
        ]);
  }

  void _onTap(int index) {
    ref.read(dashboardControllerProvider.notifier).setPosition(index);

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/library');
        break;
      case 3:
        context.go('/profile');
        break;
      default:
    }
  }
}
