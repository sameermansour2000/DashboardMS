import 'package:fintech_dashboard_clone/layout/navigation_panel.dart';
import 'package:fintech_dashboard_clone/responsive.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Widget content;

  const AppLayout({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: content,
              ),
            ),
            const NavigationPanel(
              axis: Axis.horizontal,
            ),
          ],
        ),
        desktop: Row(
          children: [
            const NavigationPanel(
              axis: Axis.vertical,
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50),
                    Expanded(child: content),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
