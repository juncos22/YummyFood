import 'package:flutter/material.dart';
import 'package:recipe_app/models/nav_item.dart';
import 'package:recipe_app/screens/home/home_screen.dart';
import 'package:recipe_app/screens/profile/profile_screen.dart';

class NavItems extends ChangeNotifier {
  int selectedIndex = 0;
  void changeNavIndex({required int index}) {
    this.selectedIndex = index;
    notifyListeners();
  }

  List<NavItem> items = [
    NavItem(id: 1, icon: 'assets/icons/home.svg', destination: HomeScreen()),
    NavItem(id: 2, icon: 'assets/icons/heart.svg', destination: null),
    NavItem(id: 3, icon: 'assets/icons/user.svg', destination: ProfileScreen()),
  ];
}
