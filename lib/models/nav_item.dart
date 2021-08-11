import 'package:flutter/material.dart';
import 'package:recipe_app/screens/home/home_screen.dart';
import 'package:recipe_app/screens/profile/profile_screen.dart';
import 'package:recipe_app/screens/recipe_list/recipe_list_screen.dart';

class NavItem {
  final int id;
  final String icon;
  final Widget? destination;

  NavItem({required this.id, required this.icon, required this.destination});

  bool destinationChecker() {
    return this.destination != null;
  }
}
