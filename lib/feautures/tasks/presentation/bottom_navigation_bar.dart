import 'package:flutter/material.dart';

import '../../settings/presentation/settings_screen.dart';
import 'tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[TasksScreen(), SettingsScreen()][currentIndex],
      bottomNavigationBar: NavigationBar(
        // indicatorColor: Colors.amber,
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Badge(
              // label: Text('2'),
              child: Icon(Icons.note_alt),
            ),
            icon: Badge(
              // label: Text('2'),
              child: Icon(Icons.note_alt_outlined),
            ),
            label: "Notes",
          ),
        ],
      ),
    );
  }
}
