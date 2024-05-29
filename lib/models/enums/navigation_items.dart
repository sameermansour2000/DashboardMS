import 'package:flutter/material.dart';

enum NavigationItems {
  home,
  users,
  panel,
  add,
  ticket,
}

extension NavigationItemsExtensions on NavigationItems {
  IconData get icon {
    switch (this) {
      case NavigationItems.home:
        return Icons.home;
      case NavigationItems.panel:
        return Icons.bar_chart;
      case NavigationItems.add:
        return Icons.add_circle;
      case NavigationItems.ticket:
        return Icons.airplane_ticket;
      default:
        return Icons.person;
    }
  }
}
