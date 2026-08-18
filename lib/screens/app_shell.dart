import 'package:flutter/material.dart';
import 'alerts_screen.dart';
import 'dashboard_screen.dart';
import 'live_map_screen.dart';
import 'profile_screen.dart';
import 'search_trip_screen.dart';
import '../theme/app_theme.dart';
import 'package:rapidpulse_my/model/user_model.dart';

class AppShell extends StatefulWidget {
  final User? user;

  const AppShell({super.key, this.user,});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  var index = 0;
  late final pages = [
    DashboardScreen(user: widget.user),
    const SearchTripScreen(),
    const LiveMapScreen(),
    const AlertsScreen(),
    ProfileScreen(user: widget.user),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: pages[index]),
    bottomNavigationBar: NavigationBar(
      selectedIndex: index,
      indicatorColor: mint,
      onDestinationSelected: (value) => setState(() => index = value),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(icon: Icon(Icons.search), label: 'Plan'),
        NavigationDestination(
          icon: Icon(Icons.map_outlined),
          selectedIcon: Icon(Icons.map),
          label: 'Map',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_none),
          selectedIcon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    ),
  );
}
