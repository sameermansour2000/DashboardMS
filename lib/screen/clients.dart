import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintech_dashboard_clone/screen/services/clients_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  final int documentsPerPage = 10;
  late int currentLimit;
  String ser = '';

  @override
  void initState() {
    currentLimit = documentsPerPage;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ser = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 640,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: fetchData(currentLimit, ser),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List client = snapshot.data.docs as List;
              print('..............................................');
              print(client);
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    ser = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  hintText: "Search something...",
                                  icon: Icon(CupertinoIcons.search),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Clients",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {}),
                                const SizedBox(width: 20),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: List.generate(
                                client.length,
                                (index) => Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: ListTile(
                                    onTap: () {
                                      showDialog(
                                        barrierColor: Colors.transparent,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                const Color(0xfffab585),
                                            title: Image.asset(
                                              'assets/logo_text.png',
                                              height: 50,
                                            ),
                                            content: const Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(''),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              // InkWell(
                                              //   onTap: () {
                                              //     Navigator.pop(context);
                                              //     Navigator.push(
                                              //         context,
                                              //         MaterialPageRoute(
                                              //             builder: (context) =>
                                              //                 HomeChat(
                                              //                     userId: client[
                                              //                             index]
                                              //                         [
                                              //                         'uid'])));
                                              //   },
                                              //   child: Container(
                                              //       width:
                                              //           MediaQuery.of(context)
                                              //                   .size
                                              //                   .width /
                                              //               2,
                                              //       alignment: Alignment.center,
                                              //       padding: const EdgeInsets
                                              //               .symmetric(
                                              //           vertical: 12),
                                              //       decoration:
                                              //           const ShapeDecoration(
                                              //         gradient: LinearGradient(
                                              //             colors: [
                                              //               Color(0xffE4B16C),
                                              //               Color(0xffDE5D76),
                                              //             ]),
                                              //         shape:
                                              //             RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius.all(
                                              //                   Radius.circular(
                                              //                       10)),
                                              //         ),
                                              //       ),
                                              //       child: const Text(
                                              //         'Chats',
                                              //         style: TextStyle(
                                              //             fontWeight:
                                              //                 FontWeight.w900,
                                              //             fontSize: 20),
                                              //       )),
                                              // ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             ClientServicesPage(
                                                  //                 userId: client[
                                                  //                         index]
                                                  //                     ['id'])));
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12),
                                                    decoration:
                                                        const ShapeDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Color(0xffE4B16C),
                                                            Color(0xffDE5D76),
                                                          ]),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Services',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 20),
                                                    )),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    title: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            client[index]['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    trailing: client[index]['is_online']
                                        ? MaterialButton(
                                            color: Colors.blueAccent,
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(client[index]['id'])
                                                  .set(
                                                {'is_online': false},
                                                SetOptions(merge: true),
                                              );
                                            },
                                            child: const Text(
                                              'Restrict',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : MaterialButton(
                                            color: Colors.redAccent,
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(client[index]['id'])
                                                  .set(
                                                {'is_online': true},
                                                SetOptions(merge: true),
                                              );
                                            },
                                            child: const Text(
                                              'UnRestrict',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                    subtitle: Text(client[index]['email']),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            currentLimit += documentsPerPage;
          });
        },
        label: const Text('More'),
      ),
    );
  }

  Stream<QuerySnapshot> fetchData(int limit, String text) {
    return text.isNotEmpty
        ? FirebaseFirestore.instance
            .collection('users')
            .where('username', isGreaterThanOrEqualTo: text)
            .limit(limit)
            .snapshots()
        : FirebaseFirestore.instance
            .collection('users')
            .limit(limit)
            .snapshots();
  }
}
