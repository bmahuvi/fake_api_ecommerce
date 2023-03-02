import 'package:fake_api/logic/view_models/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NavigationProvider>(
          builder: (context, page, child) => page.appPage),
      bottomNavigationBar: Consumer<NavigationProvider>(
          builder: (context, nav, child) => NavigationBar(
                  selectedIndex: nav.selectedTabIndex,
                  onDestinationSelected: (newTabIndex) {
                    nav.changeTab(newTabIndex);
                  },
                  destinations: const [
                    NavigationDestination(
                        icon: Icon(Icons.explore_outlined),
                        selectedIcon: Icon(Icons.explore),
                        label: 'Explore'),
                    NavigationDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard),
                        label: 'Categories'),
                    NavigationDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: 'Profile'),
                    NavigationDestination(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings),
                        label: 'Settings'),
                  ])),
    );
  }
}
