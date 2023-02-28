import 'package:fake_api/ui/products/product_categories.dart';
import 'package:flutter/material.dart';

import '../../ui/home/home_view.dart';
import '../../ui/profile/profile_view.dart';
import '../../ui/settings/settings_view.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  final List<Widget> _appPages = [
    const HomeView(),
    const ProductCategories(),
    const ProfileView(),
    const SettingsView(),
  ];
  Widget get appPage => _appPages[selectedTabIndex];

  void changeTab(int tabValue) {
    _selectedTabIndex = tabValue;
    notifyListeners();
  }
}
