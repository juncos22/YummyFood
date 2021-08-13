import 'package:flutter/material.dart';

class NavItem {
  final int id;
  final String icon;
  final Widget? destination;

  NavItem({required this.id, required this.icon, required this.destination});

  bool destinationChecker() {
    return this.destination != null;
  }
}
