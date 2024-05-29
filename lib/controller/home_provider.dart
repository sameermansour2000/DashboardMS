import 'package:flutter/material.dart';

import '../screen/clients.dart';
import '../screen/main_screen.dart';
import '../screen/tickets/replay_ticket.dart';
import '../screen/services/add_post.dart';
import '../screen/services/services_page.dart';

class HomeController with ChangeNotifier {
  int currentPage = 0;
  List page = [
    const MainScreen(),
    const Clients(),
    const ServicesPage(),
    const AddServices(),
    const ReplyTicket()

  ];

  updateHomeUi(int index) {
    currentPage = index;
    notifyListeners();
  }
}
