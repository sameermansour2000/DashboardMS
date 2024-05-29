import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth/pallete.dart';
import '../auth/widgets/gradient_button.dart';

class ReplyTicket extends StatefulWidget {
  const ReplyTicket({Key? key}) : super(key: key);

  @override
  State<ReplyTicket> createState() => _ReplyTicketState();
}

class _ReplyTicketState extends State<ReplyTicket> {
  TextEditingController answer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('tickets').where('answer',isEqualTo:false ).snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List documentIDs = snapshot.data.docs as List;
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  elevation: 5.0,
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
color:Color(
    0xa9fab585) ,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        children: [
                          ...List.generate(
                            documentIDs.length,
                            (index) => Container(
                              width: MediaQuery.of(context).size.width/2,

                              margin: const EdgeInsets.only(bottom: 20),
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Question :- ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 32,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            documentIDs[index]['question'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 32,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Email :- ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 32,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            documentIDs[index]['email'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 32,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20.0),
                                      documentIDs[index]['image'] == ""
                                          ? Container()
                                          : Image(
                                              width: 400,
                                              height: 200,
                                              image: NetworkImage(
                                                documentIDs[index]['image'],
                                              )),
                                      const SizedBox(height: 20.0),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 130,
                                              child: GradientButton(
                                                onTap: () {
                                                  showDialog(
                                                    barrierColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            const Color(
                                                                0xfffab585),
                                                        title: Image.asset(
                                                          'assets/logo_text.png',
                                                          color: Colors.black,
                                                          height: 50,
                                                        ),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(''),
                                                            const SizedBox(
                                                              height: 16,
                                                            ),
                                                            SizedBox(
                                                              width: 400,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    answer,
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding:
                                                                      const EdgeInsets
                                                                          .all(27),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Pallete
                                                                          .borderColor,
                                                                      width: 3,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Pallete
                                                                          .gradient2,
                                                                      width: 3,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  hintText:
                                                                      'Answer',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'tickets')
                                                                      .doc(documentIDs[
                                                                              index]
                                                                          [
                                                                          'docId'])
                                                                      .set({
                                                                    'theAnswer':
                                                                        answer
                                                                            .text,
                                                                    'answer':
                                                                        true,
                                                                    'timeAnswer':
                                                                        DateTime
                                                                            .now()
                                                                  }, SetOptions(merge: true)).then(
                                                                          (value) =>
                                                                              Navigator.pop(context));
                                                                },
                                                                child:
                                                                    Container(
                                                                        alignment: Alignment
                                                                            .center,
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                12),
                                                                        decoration:
                                                                            const ShapeDecoration(
                                                                          gradient:
                                                                              LinearGradient(colors: [
                                                                            Color(0xffE4B16C),
                                                                            Color(0xffDE5D76),
                                                                          ]),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10)),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                          'Answer ',
                                                                          style: TextStyle(
                                                                                fontWeight: FontWeight.w900,
                                                                                fontSize: 16
                                                                                ,color: Colors.white),
                                                                        ),
                                                                            )),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(

                                                                        alignment: Alignment
                                                                            .center,
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                12),
                                                                        decoration:
                                                                            const ShapeDecoration(
                                                                          gradient:
                                                                              LinearGradient(colors: [
                                                                            Color(0xffE4B16C),
                                                                            Color(0xffDE5D76),
                                                                          ]),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10)),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                          'Cancel',
                                                                          style: TextStyle(
                                                                                fontWeight: FontWeight.w900,
                                                                                fontSize: 16
                                                                          ,color: Colors.white),
                                                                        ),
                                                                            )),
                                                              ),
                                                            ],
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                title: 'Answer',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
