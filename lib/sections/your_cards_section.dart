import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintech_dashboard_clone/widgets/category_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../styles/styles.dart';

class CardsSection extends StatefulWidget {
  const CardsSection({Key? key}) : super(key: key);

  @override
  State<CardsSection> createState() => _CardsSectionState();
}

class _CardsSectionState extends State<CardsSection> {
  bool status = false;
  TextEditingController notificationController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return CategoryBox(title: "Subscriptions", suffix: Container(), children: [
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Styles.defaultLightWhiteColor,
          borderRadius: Styles.defaultBorderRadius,
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Post Options',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('subscriptions')
                        .doc('subscriptions')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        return Switch.adaptive(
                            activeColor: Colors.redAccent,
                            inactiveThumbColor: Colors.black,
                            activeTrackColor: Colors.grey,
                            value: data['post_options'],
                            onChanged: (value) async {
                              await FirebaseFirestore.instance
                                  .collection('subscriptions')
                                  .doc('subscriptions')
                                  .set({
                                'post_options': value,
                              }, SetOptions(merge: true));
                            });
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Map Options',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('subscriptions')
                        .doc('subscriptions')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        return Switch.adaptive(
                            activeColor: Colors.redAccent,
                            inactiveThumbColor: Colors.black,
                            activeTrackColor: Colors.grey,
                            value: data['map_options'],
                            onChanged: (value) async {
                              await FirebaseFirestore.instance
                                  .collection('subscriptions')
                                  .doc('subscriptions')
                                  .set({
                                'map_options': value,
                              }, SetOptions(merge: true));
                            });
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      InkWell(
        onTap: () {
          showDialog(
            barrierColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xfffab585),
                title: Image.asset(
                  'assets/logo_text.png',
                  color: Colors.red,
                  height: 50,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Notification'),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: notificationController,
                    ),
                  ],
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      sendPushMessageToTopic(
                          notificationController.text, 'Money Saving');
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xffE4B16C),
                            Color(0xffDE5D76),
                          ]),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text(
                          'Push',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        )),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Styles.defaultLightWhiteColor,
            borderRadius: Styles.defaultBorderRadius,
          ),
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Expanded(
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.pinkAccent,
                ),
              ),
              const Expanded(
                child: Text(
                  'Send Notification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
      )
    ]);
  }

  void sendPushMessageToTopic(String body, String title) async {
    try {
      final response = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAEM1n0lc:APA91bGbuFICjXvGvxn-9EFcfGkvB53m_O2ttOuh3UjMy-DSSt8I_KqnbuC36DjahGE67CSS1U1OHe8lKYuz8-JYh11xVJ2XgpWYZ3dDdFIB1qQ_-yg3WemBEBadnMrByQUxbnJWd3-O',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": '/topics/all', // Set the topic here
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Push notification sent successfully to topic:");
      } else {
        print("Failed to send push notification to topic: ");
      }
    } catch (e) {
      print("Error sending push notification: $e");
    }
  }
}
