import 'package:fintech_dashboard_clone/styles/styles.dart';
import 'package:flutter/material.dart';

class UpgradeProSection extends StatelessWidget {
  const UpgradeProSection({Key? key}) : super(key: key);
  final String welcomeMessage = "Welcome, !\n\n"
      "We're excited to have you on board.\n"
      "Explore the dashboard and make the most of our features.\n"
      "If you have any questions or need assistance, feel free to reach out to our support team.\n\n"
      "Happy exploring!";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Styles.defaultYellowColor,
        borderRadius: Styles.defaultBorderRadius,
      ),
      padding: EdgeInsets.symmetric(horizontal: Styles.defaultPadding),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 19,
                      ),
                      children: [
                        TextSpan(
                          text: welcomeMessage,
                        ),
                        TextSpan(
                          text: "   Admin",
                          style: TextStyle(
                              color: Styles.defaultRedColor,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset("assets/astranaut.png"),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                height: 50,
                width: 50,
                child: IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
