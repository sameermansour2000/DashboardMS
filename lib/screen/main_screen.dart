import 'package:fintech_dashboard_clone/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../responsive.dart';
import '../sections/latest_transactions.dart';
import '../sections/upgrade_pro_section.dart';
import '../sections/your_cards_section.dart';
import '../styles/styles.dart';
import 'auth/changePassword.dart';
import 'auth/widgets/gradient_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Main Panel
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Styles.defaultPadding,
                  ),
                  child: const UpgradeProSection(),
                ),
              ),
              const Expanded(
                flex: 2,
                child: LatestTransactions(),
              ),
            ],
          ),
        ),
        // Right Panel
        Visibility(
          visible: Responsive.isDesktop(context),
          child: Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: Styles.defaultPadding),
              child: Column(
                children: [
                  const CardsSection(),
                  const SizedBox(
                    height: 20,
                  ),
                  GradientButton(
                    title: 'Logout',
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GradientButton(
                    title: 'Change Password',
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePassword()));
                    },
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
