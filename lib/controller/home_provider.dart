import 'package:flutter/material.dart';

import '../screen/clients.dart';
import '../screen/main_screen.dart';

class HomeController with ChangeNotifier {
  int currentPage = 0;
  List page = [
    const MainScreen(),
    const Clients(),

  ];

  updateHomeUi(int index) {
    currentPage = index;
    notifyListeners();
  }
}
