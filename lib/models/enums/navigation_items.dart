import 'package:flutter/material.dart';

enum NavigationItems {
  home,
  users,

}

extension NavigationItemsExtensions on NavigationItems {
  IconData get icon {
    switch (this) {
      case NavigationItems.home:
        return Icons.home;

      default:
        return Icons.person;
    }
  }
}
