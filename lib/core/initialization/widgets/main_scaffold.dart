import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // сам StatefulNavigationShell — это Widget
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // повторный тап по уже активному табу вернёт его в initial location
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Badge(
              // label: Text('2'),
              child: Icon(Icons.settings_applications_outlined),
            ),
            icon: Badge(
              // label: Text('2'),
              child: Icon(Icons.settings_applications),
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
